<?php

class Appointment extends DataObject
{
    private static $db = array(
        'Date'              =>  'SS_Datetime',
        'Memo'              =>  'Text',
        'Status'            =>  'Enum("Arranged,Delivered,Cancelled")'
    );

    private static $has_one = array(
        'Business'          =>  'Business',
        'Client'            =>  'Member',
        'OriginalRequest'   =>  'Interest'
    );

    private static $default_sort = array(
        'ID'                =>  'DESC'
    );

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (!empty($this->Date)) {
            if (empty($this->original['Date'])) {
                $this->SendEmail();
            } elseif (($this->original['Date'] != $this->Date) || (empty($this->original['Memo']) && !empty($this->Memo)) || (!empty($this->original['Memo']) && $this->original['Memo'] != $this->Memo )) {
                $this->SendEmail();
            }
        }
    }

    /**
     * Event handler called after writing to the database.
     */
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        if ($this->Status == 'Cancelled') {
            $this->SendEmail();
        }

        if ($this->Status == 'Delivered') {
            $this->SetupRatingInvitations();
        }
    }

    private function SetupRatingInvitations()
    {
        $rating_first               =   new Rating();
        $rating_second              =   new Rating();

        $rating_first->Key          =   sha1(mt_rand() . mt_rand());
        $rating_second->Key         =   sha1(mt_rand() . mt_rand());

        $rating_first->GiverID      =   $this->ClientID;
        $rating_first->TakerID      =   $this->Business()->BusinessOwnerID;
        $rating_first->TargetRole   =   'Tradesperson';

        $rating_second->GiverID     =   $this->Business()->BusinessOwnerID;
        $rating_second->TakerID     =   $this->ClientID;
        $rating_second->TargetRole  =   'Client';

        $rating_first->write();
        $rating_second->write();

        // feedback invitation goes here
        $invitation_first           =   new FeedbackInvitation($rating_first->Giver(), 'Client', $rating_first);
        $invitation_second          =   new FeedbackInvitation($rating_second->Giver(), 'Tradesman', $rating_second);

        $invitation_first->send();
        $invitation_second->send();
    }

    private function SendEmail()
    {
        $isNew = empty($this->original['Date']) ? true : false;
        $state = false;
        if (!empty($this->Status) && $this->Status != 'Arranged') {
            $state = $this->Status;
        }
        $email = new AppointmentConfirmation($this, $isNew, $state);
        $email->send();
    }

    public function getData()
    {
        $client     =   $this->Client();
        return  array(
                    'ID'        =>  $this->ID,
                    'Date'      =>  $this->Date,
                    'Address'   =>  $client->FullAddress,
                    'Lat'       =>  $client->Lat,
                    'Lng'       =>  $client->Lng,
                    'Client'    =>  $client->getDisplayName(),
                    'Portrait'  =>  !empty($client->Portrait()->ImageID) ? $client->Portrait()->Image()->Cropped()->FillMax(16, 16)->URL : '/themes/default/images/default-portrait.png',
                    'GKey'      =>  Config::inst()->get('GoogleAPIs', 'Map'),
                    'CSRF'      =>  Session::get('SecurityID'),
                    'Memo'      =>  $this->Memo
                );
    }
}

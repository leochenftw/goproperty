<?php

class Rental extends DataObject
{
    private static $db = array(
        'Start'         =>  'Date',
        'End'           =>  'Date',
        'UseNotice'     =>  'Boolean',
        'Terminated'    =>  'Boolean',
        'ActualEndDate' =>  'Date'
    );

    private static $has_one = array(
        'Renter'        =>  'Member',
        'Property'      =>  'PropertyPage', // <- this needs to go
        'inProperty'    =>  'Property'
    );

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if ($this->Terminated) {
            $this->ActualEndDate = date("Y-m-d");
        }
    }

    /**
     * Event handler called after writing to the database.
     */
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($this->PropertyID);
        if ($this->Terminated) {
            $property->isGone   =   false;
            $property->writeToStage('Stage');

            $rating_first               =   new Rating();
            $rating_second              =   new Rating();

            $rating_first->Key          =   sha1(mt_rand() . mt_rand());
            $rating_second->Key         =   sha1(mt_rand() . mt_rand());

            $rating_first->GiverID      =   $this->RenterID;
            $rating_first->PropertyID   =   $this->PropertyID;

            $rating_second->GiverID     =   $this->Property()->ListerID;
            $rating_second->TakerID     =   $this->RenterID;

            $rating_first->write();
            $rating_second->write();

            // feedback invitation goes here
            $invitation_first           =   new FeedbackInvitation($rating_first->Giver(), 'Tenant', $rating_first);
            $invitation_second          =   new FeedbackInvitation($rating_second->Giver(), 'Landlord', $rating_second);

            $invitation_first->send();
            $invitation_second->send();
        }

        if (!empty($this->PropertyID)) {
            $property->doUnpublish();
        }
    }
}

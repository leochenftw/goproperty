<?php

class Appointment extends DataObject
{
    private static $db = array(
        'Date'      =>  'SS_Datetime',
        'Memo'      =>  'Text',
        'EmailSent' =>  'Boolean'
    );

    private static $has_one = array(
        'Business'  =>  'Business',
        'Client'    =>  'Member'
    );

    private static $default_sort = array(
        'ID'        =>  'DESC'
    );

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (!empty($this->Date) && !$this->EmailSent) {
            $email = new AppointmentConfirmation($this);
            $email->send();
            $this->EmailSent    =   true;
        }
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

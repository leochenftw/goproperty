<?php

class Appointment extends DataObject
{
    private static $db = array(
        'Date'      =>  'SS_Datetime',
        'Memo'      =>  'Text'
    );

    private static $has_one = array(
        'Business'  =>  'Business',
        'Client'    =>  'Member'
    );
}

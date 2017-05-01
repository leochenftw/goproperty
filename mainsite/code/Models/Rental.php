<?php

class Rental extends DataObject
{
    private static $db = array(
        'Start'     =>  'Date',
        'End'       =>  'Date',
        'UseNotice' =>  'Boolean'
    );

    private static $has_one = array(
        'Renter'    =>  'Member',
        'Property'  =>  'PropertyPage'
    );
}

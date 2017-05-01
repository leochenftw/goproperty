<?php

class Interest extends DataObject
{
    private static $db = array(
        'Message'   =>  'Text'
    );

    private static $has_one = array(
        'Member'    =>  'Member',
        'Property'  =>  'PropertyPage'
    );
}

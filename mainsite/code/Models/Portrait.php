<?php use SaltedHerring\Debugger;

class Portrait extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Title'     =>  'Varchar(256)',
        'x'         =>  'Int',
        'y'         =>  'Int'
    );

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Image' =>  'Image'
    );
}

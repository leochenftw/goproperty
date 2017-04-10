<?php
use SaltedHerring\Debugger;

class WishlistItem extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'TargetClass'   =>  'Varchar(32)',
        'TargetID'      =>  'Int'
    );
    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Member'        =>  'Member'
    );
}

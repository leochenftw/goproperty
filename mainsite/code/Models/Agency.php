<?php
use SaltedHerring\Debugger;

class Agency extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Title'     =>  'Varchar(128)',
        'Blurb'     =>  'Text'
    );

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'CreatedBy' =>  'Member',
        'OwnedBy'   =>  'Member',
        'Logo'      =>  'Image'
    );

    /**
     * Has_many relationship
     * @var array
     */
    private static $has_many = array(
        'Listings'  =>  'PropertyPage'
    );

    /**
     * Many_many relationship
     * @var array
     */
    private static $many_many = array(
        'Members'   =>  'Member'
    );

    public function onBeforeWrite() {
        parent::onBeforeWrite();
        if (empty($this->CreatedByID)) {
            $this->CreatedByID = Member::currentUserID();
        }
    }
}

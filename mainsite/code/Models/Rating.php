<?php

class Rating extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Stars'         =>  'Int'
    );

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Giver'         =>  'Member',
        'Taker'         =>  'Member'
    );

    public function canCreate($member = null)
    {
        if (!empty(Member::currentUser())) {
            return true;
        }

        return false;
    }

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if ($this->Stars > 5) {
            $this->Stars = 5;
        }

        if ($this->Stars < 0) {
            $this->Stars = 0;
        }

        if (!$this->exists()) {
            $this->GiverID = Member::currentUserID();
        }
    }
}

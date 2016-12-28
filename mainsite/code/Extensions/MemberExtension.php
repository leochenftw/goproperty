<?php
use SaltedHerring\Debugger;

class MemberExtension extends DataExtension
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'ValidationKey'  	 	=>	'Varchar(40)',
        'ContactNumber'         =>  'Varchar(24)'
    );
    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Portrait'          =>  'Portrait'
    );

    public function populateDefaults()
    {
		$this->owner->ValidationKey = sha1(mt_rand() . mt_rand());
	}

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->PortraitID)) {
            $portrait = new Portrait();
            $portrait->write();
            $this->PortraitID = $portrait->ID;
        }
    }

    public function onAfterWrite()
    {
		parent::onAfterWrite();

		if (!empty($this->owner->ValidationKey)) {
			$email = new ConfirmationEmail($this->owner);
			$email->send();
		}
	}

}

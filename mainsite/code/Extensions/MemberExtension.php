<?php
use SaltedHerring\Debugger;
use SaltedHerring\Grid;

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
     * Update Fields
     * @return FieldList
     */
    public function updateCMSFields(FieldList $fields)
    {
        $fields->removeByName('PortraitID');
        $fields->addFieldsToTab(
            'Root.Portrait',
            array(
                LiteralField::create('PortraitID', '<h2>' . $this->owner->PortraitID . '</h2>'),
                LiteralField::create('CropboxX', '<h3>Cropbox X: ' . $this->owner->Portrait()->CropperX . '</h3>'),
                LiteralField::create('CropboxY', '<h3>Cropbox Y: ' . $this->owner->Portrait()->CropperY . '</h3>'),
                LiteralField::create('CropboxWidth', '<h3>Cropbox Width: ' . $this->owner->Portrait()->CropperWidth . '</h3>'),
                LiteralField::create('CropboxHeight', '<h3>Cropbox Height: ' . $this->owner->Portrait()->CropperHeight . '</h3>'),

                LiteralField::create('Image', $this->owner->Portrait()->Image()->FillMax(400, 400))
            )
        );
        return $fields;
    }
    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->owner->PortraitID)) {
            $portrait = new Portrait();
            $id = $portrait->write();
            $this->owner->PortraitID = $id;
        }
    }

}

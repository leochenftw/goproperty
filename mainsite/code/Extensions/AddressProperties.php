<?php
use SaltedHerring\Debugger;
use Cocur\Slugify\Slugify;
class AddressProperties extends DataExtension
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'UnitNumber'        =>  'Varchar(64)',
        'FullAddress'       =>  'Text',
        'StreetNumber'      =>  'Varchar(8)',
        'StreetName'        =>  'Varchar(512)',
        'Suburb'            =>  'Varchar(128)',
        'City'              =>  'Varchar(128)',
        'Region'            =>  'Varchar(128)',
        'Country'           =>  'Varchar(128)',
        'SuburbSlug'        =>  'Varchar(128)',
        'CitySlug'          =>  'Varchar(128)',
        'RegionSlug'        =>  'Varchar(128)',
        'Country'           =>  'Varchar(128)',
        'Lat'               =>  'Varchar(64)',
        'Lng'               =>  'Varchar(64)',
        'PostCode'          =>  'Varchar(16)'
    );

    public function updateCMSFields(FieldList $fields) {

    }

    public function onBeforeWrite() {
        parent::onBeforeWrite();
        $slugify = new Slugify();
        $this->owner->SuburbSlug = $slugify->slugify($this->owner->Suburb);
        $this->owner->CitySlug = $slugify->slugify($this->owner->City);
        $this->owner->RegionSlug = $slugify->slugify($this->owner->Region);
    }
}

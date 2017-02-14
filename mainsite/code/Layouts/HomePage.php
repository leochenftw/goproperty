<?php

class HomePage extends Page
{
    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'HomepageHero'                =>  'Image'
    );

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->addFieldToTab('Root.Main', UploadField::create(
            'HomepageHero',
            'Homepage hero image'
        ));
        return $fields;
    }
}

class HomePage_Controller extends Page_Controller
{
    public function Form()
    {
        return new PropertySearchForm($this);
    }

    public function getTiles()
    {
        return Tile::get()->limit(6);
    }
}

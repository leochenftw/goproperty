<?php

class HeroExtension extends DataExtension
{
    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'PageHero'     =>  'Image'
    );

    /**
     * Update Fields
     * @return FieldList
     */
    public function updateCMSFields(FieldList $fields)
    {
        $fields->addFieldTotTab(
            'Root.Main',
            SaltedUploader::create('PageHero', 'Page hero image')->setCropperRatio(16/9)
        );
        return $fields;
    }
}

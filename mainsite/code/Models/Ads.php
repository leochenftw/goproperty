<?php

class Ads extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = [
        'Title'     =>  'Varchar(64)',
        'AdsCode'   =>  'Text',
        'Position'  =>  'Varchar(32)',
        'Expiry'    =>  'SS_Datetime'
    ];

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = [
        'AdsImage'  =>  'Image',
        'LinkTo'    =>  'Link'
    ];

    /**
     * Has_many relationship
     * @var array
     */
    private static $has_many = [
        'Clicks'    =>  'Click'
    ];

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields     =   parent::getCMSFields();
        $fields->addFieldsToTab(
            'Root.Main',
            [
                DropdownField::create(
                    'Position',
                    'Position',
                    $this->config()->get('Position')
                )->setEmptyString('- select one -'),
                LinkField::create(
                    'LinkToID',
                    'Link to'
                )
            ]
        );

        if ($this->exists()) {
            $fields->addFieldToTab(
                'Root.Main',
                LiteralField::create('ClickCount', 'Clicks: <strong style="font-size: 24px;">' . $this->Clicks()->count() . '</strong>'),
                'Title'
            );
        }

        return $fields;
    }

    public function forTemplate()
    {
        // if (!empty($this->AdsCode)) {
        //     // return $this->renderWith();
        // }

        return $this->renderWith(['ImageAds']);
    }
}

<?php

class HomePage extends Page
{
    private static $db = array(
        'RentalFormTitle'       =>  'Varchar(128)',
        'RentalFormContent'     =>  'Text',
        'SaleFormTitle'         =>  'Varchar(128)',
        'SaleFormContent'       =>  'Text',
        'TradesFormTitle'       =>  'Varchar(128)',
        'TradesFormContent'     =>  'Text'
    );
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

        $fields->addFieldsToTab(
            'Root.RentalForm',
            array(
                TextField::create('RentalFormTitle', 'Title'),
                TextareaField::create('RentalFormContent', 'Content')
            )
        );

        $fields->addFieldsToTab(
            'Root.SaleForm',
            array(
                TextField::create('SaleFormTitle', 'Title'),
                TextareaField::create('SaleFormContent', 'Content')
            )
        );

        $fields->addFieldsToTab(
            'Root.TradespersonForm',
            array(
                TextField::create('TradesFormTitle', 'Title'),
                TextareaField::create('TradesFormContent', 'Content')
            )
        );


        $fields->addFieldToTab('Root.Main', UploadField::create(
            'HomepageHero',
            'Homepage hero image'
        ));
        return $fields;
    }
}

class HomePage_Controller extends Page_Controller
{
    public function getTiles()
    {
        return Tile::get()->limit(6);
    }
}

<?php
use SaltedHerring\Debugger;

class PropertySearchForm extends Form
{
    public function __construct($controller)
    {
        $agency = null;
        $fields = new FieldList();
        $fields->push(DropdownField::create(
            'Region',
            'Region',
            Config::inst()->get('NewZealand', 'Regions')
        )->setEmptyString('All New Zealand')->setAttribute('data-direct-child', 'PropertySearchForm_PropertySearchForm_City'));

        $fields->push(DropdownField::create(
            'City',
            'District'
        )->setEmptyString('All districts')->setAttribute('data-direct-child', 'PropertySearchForm_PropertySearchForm_Suburb'));

        $fields->push(DropdownField::create(
            'Suburb',
            'Suburb'
        )->setEmptyString('All suburbs'));

        $fields->push(DropdownField::create(
            'PropertyType',
            'Property Type',
            $this->makeList(Config::inst()->get('PropertyPage', 'RentForm'))
        )->setEmptyString('All types'));

        $fields->push(DropdownField::create(
            'BedroomFrom',
            'Bedroom from',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBedroom'))
        )->setEmptyString('Any'));

        $fields->push(DropdownField::create(
            'BedroomTo',
            'Bedroom to',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBedroom'))
        )->setEmptyString('Any'));

        $fields->push(DropdownField::create(
            'BathroomFrom',
            'Bathroom from',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBathroom'))
        )->setEmptyString('Any'));

        $fields->push(DropdownField::create(
            'BathroomTo',
            'Bathroom to',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBathroom'))
        )->setEmptyString('Any'));

        $fields->push(TextField::create(
            'RentFrom',
            'Rent from'
        )->setAttribute('placeholder', 'Any'));

        $fields->push(TextField::create(
            'RentTo',
            'Rent to'
        )->setAttribute('placeholder', 'Any'));

        $fields->push(TextField::create(
            'Availability',
            'Available from'
        ));

        $fields->push(OptionsetField::create(
            'AllowPet',
            'Pet OK',
            array('No' => 'No', 'Yes' => 'Yes', 'Negotiable' => 'Negotiable')
        ));

        $fields->push(OptionsetField::create(
            'AllowSmoker',
            'Smoker OK',
            array('No' => 'No', 'Yes' => 'Yes')
        ));



        $actions = new FieldList();
        $actions->push(FormAction::create('doSearch', 'Search'));

        parent::__construct($controller, 'PropertySearchForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'all-properties', 'PropertySearchForm'))->addExtraClass('property-search-form');
    }

    public function doSearch($data, $form)
    {

    }

    private function makeList($array)
    {
        if (!is_array($array)) {
            $int = $array;
            $array = array();
            for ($i = 1; $i <= $int; $i++) {
                $array[] = $i;
            }
        }
        $list = array();
        foreach ($array as $key)
        {
            $list[$key] = $key;
        }
        return $list;
    }
}

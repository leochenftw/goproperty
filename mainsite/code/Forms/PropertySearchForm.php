<?php
use SaltedHerring\Debugger;
use Cocur\Slugify\Slugify;

class PropertySearchForm extends Form
{
    public function __construct($controller)
    {
        $gets   =   $controller->request->getVars();
        // Debugger::inspect($controller->request->params());
        $fields =   new FieldList();
        $fields->push(OptionsetField::create(
            'RentOrSale',
            'Rent / Sale',
            array(
                'rent'  => 'Rent',
                'sale'  =>  'Sale'
            ),
            'rent'
        ));
        $fields->push($RegionSelector = DropdownField::create(
            'Region',
            'Region',
            Config::inst()->get('NewZealand', 'Regions')
        )->setEmptyString('All New Zealand')->setAttribute('data-direct-child', 'PropertySearchForm_PropertySearchForm_City'));

        $RegionSelector->setValue('Wellington')->addExtraClass('hide');

        $fields->push(
            DropdownField::create(
                'City',
                'District'
            )->setEmptyString('All Wellington districts')
             ->setAttribute('data-direct-child', 'PropertySearchForm_PropertySearchForm_Suburb')
             ->setAttribute('data-option', !empty($controller->request->param('district')) ? $controller->request->param('district') : null)
        );

        $fields->push(
            DropdownField::create(
                'Suburb',
                'Suburb'
            )->setEmptyString('All suburbs')
             ->setAttribute('data-option', !empty($controller->request->param('suburb')) ? $controller->request->param('suburb') : null)
        );

        $fields->push(DropdownField::create(
            'RentalPropertyType',
            'Property Type',
            Config::inst()->get('PropertyPage', 'RentForm'),
            isset($gets['RentalPropertyType']) ? $gets['RentalPropertyType'] : null
        )->setEmptyString('All types'));

        $fields->push(DropdownField::create(
            'SalePropertyType',
            'Property Type',
            Config::inst()->get('PropertyPage', 'SaleForm'),
            isset($gets['SalePropertyType']) ? $gets['SalePropertyType'] : null
        )->setEmptyString('All types'));

        $fields->push(DropdownField::create(
            'BedroomFrom',
            'Bedroom from',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBedroom')),
            isset($gets['BedroomFrom']) ? $gets['BedroomFrom'] : null
        )->setEmptyString('Any'));

        $fields->push(DropdownField::create(
            'BedroomTo',
            'Bedroom to',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBedroom')),
            isset($gets['BedroomTo']) ? $gets['BedroomTo'] : null
        )->setEmptyString('Any'));

        $fields->push(DropdownField::create(
            'BathroomFrom',
            'Bathroom from',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBathroom')),
            isset($gets['BathroomFrom']) ? $gets['BathroomFrom'] : null
        )->setEmptyString('Any'));

        $fields->push(DropdownField::create(
            'BathroomTo',
            'Bathroom to',
            $this->makeList(Config::inst()->get('PropertyPage', 'MaxBathroom')),
            isset($gets['BathroomTo']) ? $gets['BathroomTo'] : null
        )->setEmptyString('Any'));

        $fields->push(TextField::create(
            'RentFrom',
            'Rent from',
            isset($gets['RentFrom']) ? $gets['RentFrom'] : null
        )->setAttribute('placeholder', 'Any'));

        $fields->push(
            TextField::create(
                'RentTo',
                'Rent to',
                isset($gets['RentTo']) ? $gets['RentTo'] : null
            )->setAttribute('placeholder', 'Any')
        );

        $fields->push(TextField::create(
            'PriceFrom',
            'Price from',
            isset($gets['PriceFrom']) ? $gets['PriceFrom'] : null
        )->setAttribute('placeholder', 'Any'));

        $fields->push(TextField::create(
            'PriceTo',
            'Price to',
            isset($gets['PriceTo']) ? $gets['PriceTo'] : null
        )->setAttribute('placeholder', 'Any'));

        $fields->push(TextField::create(
            'Availability',
            'Available from',
            isset($gets['Availability']) ? $gets['Availability'] : null
        ));

        $fields->push(OptionsetField::create(
            'AllowPet',
            'Pet OK',
            array(
                'No' => 'No',
                'Yes' => 'Yes',
                'Negotiable' => 'Negotiable'
            ),
            isset($gets['AllowPet']) ? $gets['AllowPet'] : null
        ));

        $fields->push(OptionsetField::create(
            'AllowSmoker',
            'Smoker OK',
            array('No' => 'No', 'Yes' => 'Yes'),
            isset($gets['AllowSmoker']) ? $gets['AllowSmoker'] : null
        ));

        $actions = new FieldList();
        $actions->push(FormAction::create('doSearch', 'Search'));

        parent::__construct($controller, 'PropertySearchForm', $fields, $actions);
        $this->setFormMethod('POST', true)->addExtraClass('property-search-form column is-12');
    }

    public function validate()
    {
         return true;
    }


    public function doSearch($data, $form)
    {
        // Debugger::inspect($data);

        /*
        [Region] => Northland
        [City] =>
        [Suburb] =>
        [PropertyType] => Townhouse
        [BedroomFrom] => 1
        [BedroomTo] => 3
        [BathroomFrom] => 2
        [BathroomTo] => 2
        [RentFrom] => 1000
        [RentTo] => 2000
        [Availability] => 24/02/2017
        [AllowPet] => Yes
        [AllowSmoker] => Yes
        [SecurityID] => 91d45feb9e0e4a9d678583ffd68a22f3eaf90358
        [action_doSearch] => Search
        */
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            $region     =   !empty($data['Region']) ? strtolower($data['Region']) : null;
            $district   =   !empty($data['City']) ? strtolower($data['City']) : null;
            $suburb     =   !empty($data['Suburb']) ? strtolower($data['Suburb']) : null;

            if (!empty($data['Availability'])) {
                $dates = explode('/', $data['Availability']);
                $dates = array_reverse($dates);
                $data['Availability'] = implode('-', $dates);
            }

            $url        =   '/list';

            $slugify = new Slugify();

            if (!empty($region)) {
                $region = $slugify->slugify($region);
                $url .= "/$region";
            }

            if (!empty($district)) {
                $district = $slugify->slugify($district);
                $url .= "/$district";
            }

            if (!empty($suburb)) {
                $suburb = $slugify->slugify($suburb);
                $url .= "/$suburb";
            }

            unset($data['Region']);
            unset($data['City']);
            unset($data['Suburb']);
            unset($data['SecurityID']);
            unset($data['action_doSearch']);


            $link = $url . '?';
            foreach ($data as $key => $value) {
                if (strlen($value) > 0) {
                    if (is_array($value)) {
                        foreach ($value as $value_item) {
                            $link .= $key . '[]=' . $value_item . '&';
                        }
                    } else {
                        $link .= ($key . '=' . $value . '&');
                    }
                }
            }

            $link = rtrim(rtrim($link, '&'), '?');
            $url = $link;

            return $this->controller->redirect($url);

        }

        return $this->controller->httpError(400);
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

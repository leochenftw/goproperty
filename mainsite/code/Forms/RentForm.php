<?php

use SaltedHerring\Debugger;

class RentForm extends PropertyForm
{
	public function __construct($controller, $prop = null)
    {
		parent::__construct($controller, 'RentForm', $prop);
        $fields = parent::Fields();
        $actions = parent::Actions();

        $fields->push(TextField::create('WeeklyRent', 'Rent per week', !empty($prop) ? $prop->WeeklyRent : null));
        $fields->push(DateField::create('DateAvailable', 'Date available', !empty($prop) ? $prop->DateAvailable : null));

        $fields->push(OptionsetField::create(
            'AllowPet',
            'Pet OK',
            array('No' => 'No', 'Yes' => 'Yes', 'Negotiable' => 'Negotiable'),
            !empty($prop) ? $prop->AllowPet : 'No'
        ));

        $fields->push(OptionsetField::create(
            'AllowSmoker',
            'Smoker OK',
            array('No' => 'No', 'Yes' => 'Yes'),
            !empty($prop) ? $prop->AllowSmoker : 'No'
        ));

        $fields->push($furnishings = TextareaField::create('Furnishings', 'Furnishing'));

        $fields->push($testimonial = TextareaField::create('Testimonial', 'Testimonial')->setAttribute('placeholder', 'Customer partner network the property has features such as termsheet facebook focus product management.'));

        if (!empty($prop)) {
            $testimonial->setValue($prop->Testimonial);
            $furnishings->setValue($prop->Furnishings);
        }

        $fields->push(DropdownField::create(
            'IdealTenants',
            'Ideal tenants',
            Config::inst()->get('PropertyPage', 'IdealTenants'),
            !empty($prop) ? $prop->IdealTenants : null
        )->setEmptyString('- select one -'));

        $fields->push(DropdownField::create(
            'MaxCapacity',
            'Max number of tenants',
            $this->makeList('MaxCapacity'),
            !empty($prop) ? $prop->MaxCapacity : null
        )->setEmptyString('- select one -'));

		$fields->changeFieldOrder(array(
            'DateAvailable',
            'PropertyType',
			'WeeklyRent',
            'FullAddress',
            'AgencyReference',
			'MaxCapacity',
			'NumBedrooms',
			'NumBathrooms',
			'AllowPet',
			'AllowSmoker',
			'Content',
			'Furnishings',
			'SmokeAlarm',
			'Amenities',
			'Parking',
			'IdealTenants',
			'Testimonial'
        ));

        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', "RentForm"));
    }
}

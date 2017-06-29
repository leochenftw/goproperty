<?php
use SaltedHerring\Debugger;

class FilterForm extends Form
{
    public function __construct($controller)
    {
        $fields = new FieldList();
        $request = $controller->request;
        $hasLocationParam = false;

        if ($region = $request->param('region')) {
            // $region = str_replace('Region: ', '', $region);
            $fields->push(LiteralField::create('Region', '<div class="is-inline-block relative"><button class="btn-region" name="region">' . $region . '</button><span class="icon"><i class="fa fa-close"></i></span></div>'));
            $hasLocationParam = true;
        }

        if ($district = $request->param('district')) {
            // $district = str_replace('City: ', '', $district);
            $fields->push(LiteralField::create('City', '<div class="is-inline-block relative"><button class="btn-city" name="district">' . $district . '</button><span class="icon"><i class="fa fa-close"></i></span></div>'));
            $hasLocationParam = true;
        }

        if ($suburb = $request->param('suburb')) {
            // $suburb = str_replace('Suburb: ', '', $suburb);
            $fields->push(LiteralField::create('Suburb', '<div class="is-inline-block relative"><button class="btn-suburb" name="suburb">' . $suburb . '</button><span class="icon"><i class="fa fa-close"></i></span></div>'));
            $hasLocationParam = true;
        }

        $terms = $request->getVars();
        unset($terms['url']);
        unset($terms['SecurityID']);
        unset($terms['action_Filter']);
        unset($terms['start']);

        if (count($terms) > 0) {

            foreach ($terms as $key => $value) {
                if ($key == 'RentalPropertyType' || $key == 'SalePropertyType') {
                    // Debugger::inspect($value);
                    $raw_value = $value;
                    $value = PropertyPage_Controller::translateType($value, $key == 'RentalPropertyType' ? 'RentForm' : 'SaleForm');
                }

                $fields->push(LiteralField::create($key, '<div class="is-inline-block relative"><button name="' . $key . '">' . $this->friendlify($key) . $value . '</button><span class="icon"><i class="fa fa-close"></i></span></div>'));
                $fields->push(HiddenField::create(
                    $key,
                    $key,
                    ($key == 'RentalPropertyType' || $key == 'SalePropertyType') ? $raw_value : $value
                ));
            }

        } elseif (!$hasLocationParam) {
            // Debugger::inspect('?');
            $fields->push(LiteralField::create('NOFILTER', '<p style="font-size: 16px;"><em>You are seeing all properties</em></p>'));
        }

        $actions = new FieldList();
        $actions->push(FormAction::create('Filter', 'Filter')->addExtraClass('hide'));

        parent::__construct($controller, 'FilterForm', $fields, $actions);
        $this->setFormMethod('GET', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'list'))->addExtraClass('filter-form');
    }

    public function Filter($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {

            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400, 'not matching');
    }

    private function friendlify($name)
    {
        switch ($name) {
            case 'RentOrSale':
                $name = '';
                break;

            case 'RentalPropertyType':
                $name = '';
                break;

            case 'SalePropertyType':
                $name = '';
                break;

            case 'BedroomFrom':
                $name = 'Bedrooms from';
                break;

            case 'BedroomTo':
                $name = 'Bedrooms up to';
                break;

            case 'BathroomFrom':
                $name = 'Bathrooms from';
                break;

            case 'BathroomTo':
                $name = 'Bathroom up to';
                break;

            case 'RentFrom':
                $name = 'Rent from';
                break;

            case 'RentTo':
                $name = 'Rent up to';
                break;

            case 'PriceFrom':
                $name = 'Price from';
                break;

            case 'PriceTo':
                $name = 'Price up to';
                break;

            case 'Availability':
                $name = 'Available from';
                break;

            case 'AllowPet':
                $name = 'Pet OK';
                break;

            case 'AllowSmoker':
                $name = 'Smoker OK';
                break;

            default:
                $name = $name;
        }

        return $name . (strlen($name) > 0 ? ': ' : '');
    }

}

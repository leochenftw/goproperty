<?php
use SaltedHerring\Debugger;

class PropertyLister extends Page_Controller
{
    /**
     * Defines methods that can be called directly
     * @var array
     */
    private static $allowed_actions = array(
        'FilterForm'          =>  true
    );
    public function index($request)
    {
        //Debugger::inspect($request->param('region'));
        // $properties = PropertyPage::get();
        $properties =   RentalListing::get();
        //
        // if ($region = $request->param('region')) {
        //     $properties = $properties->filter(array('RegionSlug' => $region));
        // }
        //
        // if ($district = $request->param('district')) {
        //     $properties = $properties->filter(array('CitySlug' => $district));
        // }
        //
        // if ($suburb = $request->param('suburb')) {
        //     $properties = $properties->filter(array('SuburbSlug' => $suburb));
        // }
        //
        // // Debugger::inspect($region . '/' . $district . '/' . $suburb);
        //
        // $filter = array();
        //
        // if ($type = $request->getVar('RentalPropertyType')) {
        //     $filter['PropertyType'] = $type;
        // }
        //
        // if ($type = $request->getVar('SalePropertyType')) {
        //     $filter['PropertyType'] = $type;
        // }
        //
        // if ($ros = $request->getVar('RentOrSale')) {
        //     $filter['RentOrSale'] = $ros;
        // }
        //
        // if ($min_bed = $request->getVar('BedroomFrom')) {
        //     $filter['NumBedrooms:GreaterThanOrEqual'] = $min_bed;
        // }
        //
        // if ($max_bed = $request->getVar('BedroomTo')) {
        //     $filter['NumBedrooms:LessThanOrEqual'] = $max_bed;
        // }
        //
        // if ($min_bath = $request->getVar('BathroomFrom')) {
        //     $filter['NumBathrooms:GreaterThanOrEqual'] = $min_bath;
        // }
        //
        // if ($max_bath = $request->getVar('BathroomTo')) {
        //     $filter['NumBathrooms:LessThanOrEqual'] = $max_bath;
        // }
        //
        // if ($min_rent = $request->getVar('RentFrom')) {
        //     $filter['WeeklyRent:GreaterThanOrEqual'] = $min_rent;
        // }
        //
        // if ($max_rent = $request->getVar('RentTo')) {
        //     $filter['WeeklyRent:LessThanOrEqual'] = $max_rent;
        // }
        //
        // if ($available_from = $request->getVar('Availability')) {
        //     $filter['DateAvailable:GreaterThanOrEqual'] = $available_from;
        // }
        //
        // if ($pet = $request->getVar('AllowPet')) {
        //     $filter['AllowPet'] = $pet;
        // }
        //
        // if ($smoker = $request->getVar('AllowSmoker')) {
        //     $filter['AllowSmoker'] = $smoker;
        // }
        //
        // $properties = $properties->filter($filter);

        $properties = new PaginatedList($properties, $request);
        $properties->setPageLength(12);

        return $this->customise(array('Properties' => $properties))->renderWith(array('PropertyList', 'Page'));
    }

    public function getTitle()
    {
        $segments = $_GET['url'];
        $segments = explode('/', $segments);
        $region = $district = $suburb = '';
        if (count($segments) > 2) {
            $region = ' › ' . $segments[2];
        }

        if (count($segments) > 3) {
            $district = ' › ' . $segments[3];
        }

        if (count($segments) > 4) {
            $suburb = ' › ' . $segments[4];
        }

        return 'Properties' . $region . $district . $suburb;
    }

    public function Title()
    {
        return $this->getTitle();
    }

    public function FilterForm()
    {
        return new FilterForm($this);
    }
}

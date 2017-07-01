<?php
use SaltedHerring\Debugger;

class TradesmenLister extends Page_Controller
{
    private $business = null;
    /**
     * Defines methods that can be called directly
     * @var array
     */
    private static $allowed_actions = array(
        'ContactForm'
    );

    public function index($request)
    {
        if ($request->param('region') == 'ContactForm') {
            return $this->ContactForm();
        }

        if ($serviceSlug = $request->getVar('WorkType')) {
            $service = Service::get()->filter(array('Slug' => $serviceSlug))->first();
            $business = $service->Business();
        } else {
            $business = Business::get();
        }

        $business = $business->filter(array('Listed' => true));

        $filters = array();
        if ($region = $request->param('region')) {
            $filters['RegionSlug'] = $region;
        }

        if ($district = $request->param('district')) {
            $filters['CitySlug'] = $district;
        }

        if ($suburb = $request->param('suburb')) {
            if ($suburb != 'all-suburb') {
                $filters['SuburbSlug'] = $suburb;
            }
        }

        if ($slug = $request->param('slug')) {
            $filters['Slug'] = $slug;
        }

        $business = $business->filter($filters);

        $data = array(
            'BodyClass' =>  '',
            'Business'  =>  null
        );


        if (!empty($slug)) {
            $data['BodyClass'] = 'Business';
            $business = $business->first();
            $this->business = $business;
        } else {
            $business = new PaginatedList($business, $request);
            $business->setPageLength(12);
        }

        $data['Business'] = $business;

        return $this->customise($data)->renderWith(array(!empty($slug) ? 'BusinessPage' : 'TradesmenList', 'Page'));
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

        return 'Tradesmen' . $region . $district . $suburb;
    }

    public function Title()
    {
        return $this->getTitle();
    }

    public function Link($action = NULL)
    {
        return '/tradesmen/';
    }

    public function fullURL()
    {
        return $this->request->getVar('url');
    }

    public function ContactForm()
    {
        if (empty($this->business)) {
            return new ContactForm($this);
        }

        $business = $this->business;

        return new ContactForm($this, $business->BusinessOwnerID, $business->ID);
    }

    public function getLocationBreadcrumbs()
    {
        if (empty($this->business)) {
            return parent::getLocationBreadcrumbs();
        }

        $url            =   ltrim($this->request->getVar('url'), '/');
        $segs           =   explode('/', $url);
        $first_seg      =   $segs[0];
        $base_title     =   $first_seg == 'list' ? 'All properties' : 'All business';

        $first_seg      =   '/' . $first_seg . '/';


        $region         =   $this->business->Region;
        $district       =   $this->business->City;
        $suburb         =   $this->business->Suburb;

        $region_url     =   $this->business->RegionSlug;
        $district_url   =   $this->business->CitySlug;
        $suburb_url     =   $this->business->SuburbSlug;

        $item_home      =   array(
                                'Title'     =>  $base_title,
                                'URL'       =>  $first_seg
                            );

        $item_region    =   new ArrayData(array(
                                'Title'     =>  $region,
                                'URL'       =>  $first_seg . $region_url
                            ));

        $item_city      =   new ArrayData(array(
                                'Title'     =>  $district,
                                'URL'       =>  $first_seg . $region_url . '/' . $district_url
                            ));

        $item_sub       =   new ArrayData(array(
                                'Title'     =>  $suburb,
                                'URL'       =>  $first_seg . $region_url . '/' . $district_url . '/' . $suburb_url
                            ));

        $item           =   new ArrayData(array(
                                'Title'     =>  $this->business->Title,
                            ));

        return new ArrayList(array($item_home, $item_region, $item_city, $item_sub, $item));
    }

}

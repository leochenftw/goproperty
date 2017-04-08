<?php
use SaltedHerring\Debugger;
use SaltedHerring\Grid;
use SaltedHerring\SaltedPayment;

class PropertyPage extends Page
{
    private static $extensions = array(
        'AddressProperties'
    );

    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'RentOrSale'            =>  'Enum("rent,sale")',
        'PropertyType'          =>  'Varchar(48)',
        'RateableValue'         =>  'Decimal',
        'HideRV'                =>  'Boolean',
        'ExpectdSalePrice'      =>  'Decimal',
        'WeeklyRent'            =>  'Decimal',
        'DateAvailable'         =>  'Date',
        'ContactNumber'         =>  'Varchar(24)',
        'NumBedrooms'           =>  'Int',
        'NumBathrooms'          =>  'Int',
        'Amenities'             =>  'Text',
        'Testimonial'           =>  'Text',
        'AllowPet'              =>  'Enum("No,Yes,Negotiable")',
        'AllowSmoker'           =>  'Enum("No,Yes")',
        'Furnishings'           =>  'Text',
        'Parking'               =>  'Varchar(64)',
        'IdealTenants'          =>  'Varchar(64)',
        'SmokeAlarm'            =>  'Boolean',
        'Insulation'            =>  'Boolean',
        'MaxCapacity'           =>  'Int',
        'AgencyReference'       =>  'Varchar(64)',
        'OpenHomeTimes'         =>  'SS_Datetime',
        'PriceOption'           =>  'Varchar(48)',
        'AskingPrice'           =>  'Decimal',
        'EnquiriesOver'         =>  'Decimal',
        'AuctionOn'             =>  'Date',
        'TenderCloseOn'         =>  'Date',
        'PriceByNegotiation'    =>  'Boolean',
        'PrivateTreatyDeadline' =>  'Date',
        'ListTilGone'           =>  'Boolean',
        'ListingDuration'       =>  'Int',
        'ListingCloseOn'        =>  'Date',
        'LandArea'              =>  'Int',
        'FloorArea'             =>  'Int',
        'BeenRented'            =>  'Boolean',
        'isGone'                =>  'Boolean',
        'isPaid'                =>  'Boolean'
    );

    public function getPrice()
    {
        if (!empty($this->EnquiriesOver) && $this->EnquiriesOver > 0) {
            return 'Enquiries over $' . $this->EnquiriesOver;
        }

        if (!empty($this->AskingPrice) && $this->AskingPrice > 0) {
            return 'Asking price $' . $this->AskingPrice;
        }

        if (!empty($this->RateableValue) && $this->RateableValue > 0) {
            return 'RV $' . $this->RateableValue;
        }

        if (!empty($this->WeeklyRent) && $this->WeeklyRent > 0) {
            return '$' . $this->WeeklyRent . ' per week';
        }

        return '- price not specified -';
    }

    /**
     * Define the default values for all the $db fields
     * @var array
     */
    private static $defaults = array(
        'PriceOption'           =>  'AskingPrice'
    );

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->addFieldsToTab(
            'Root.Main',
            array(
                DateField::create('DateAvailable', 'Date available'),
                TextField::create('ListingDuration', 'Days of listing'),
                TextField::create('FullRef', 'Internal reference')->performReadonlyTransformation(),
                DropdownField::create('CustomerID', 'Customer', Member::get()->map(), $this->CustomerID)->performReadonlyTransformation()
            )
        );
        $fields->addFieldsToTab(
            'Root.Location',
            array(
                TextField::create('FullAddress', 'Address'),
                TextField::create('UnitNumber', 'Unit/Room/Apartment/Flat number'),
                TextField::create('StreetNumber', 'Street number'),
                TextField::create('StreetName', 'Street'),
                TextField::create('Suburb', 'Suburb')->setDescription('slug: ' . $this->SuburbSlug),
                TextField::create('City', 'City')->setDescription('slug: ' . $this->CitySlug),
                TextField::create('Region', 'Region')->setDescription('slug: ' . $this->RegionSlug),
                TextField::create('Country', 'Country'),
                TextField::create('PostCode', 'Post code'),
                TextField::create('Lat', 'Latitude'),
                TextField::create('Lng', 'Longitude')
            )
        );

        $fields->addFieldToTab(
            'Root.Gallery',
            UploadField::create(
                'Gallery',
                'Gallery'
            )
        );

        if (!empty($this->Orders())) {
            $fields->addFieldToTab(
                'Root.Orders',
                Grid::make('Orders', 'Orders', $this->Orders(), false)
                // Grid::make('Payments', 'Payments', $this->Payments(), false, 'GridFieldConfig_RecordViewer')
            );
        }

        return $fields;
    }

    public function isPublished($human_friendly = null)
    {
        if ($live = Versioned::get_by_stage('PropertyPage', 'Live')->byID($this->ID)) {
            return !empty($human_friendly) ? 'Yes' : true;
        }

        return !empty($human_friendly) ? 'No' : false;
    }

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->Title)) {
            $this->Title = $this->FullAddress;
        }
        $parent = PropertyListingPage::get()->first();
        if (!empty($parent)) {
            $this->ParentID = $parent->ID;
        }

        if ($this->PriceOption == 'PriceByNegotiation') {
            $this->PriceByNegotiation = true;
        } else {
            $this->PriceByNegotiation = false;
        }

        if (empty($this->ListerAgencyID)) {
            $this->AgencyReference = null;
        }

        if (empty($this->FullRef)) {
            $created = new DateTime('NOW');
            $timestamp = $created->format('YmdHisu');
            $this->FullRef = strtolower(sha1(md5($timestamp.'-'.session_id())));
        }

        if (!empty($this->ListingCloseOn)) {
            // Debugger::inspect();
            $today  =   date_create(date("Y-m-d"));
            $until  =   date_create($this->ListingCloseOn);

            if ($until >= $today) {
                $diff   =   date_diff($today,$until);
                $this->ListingDuration = $diff->days + 1;
            }
        }

        /*
        'Amenities'             =>  'Text',
        'Testimonial'           =>  'Text',
        'Furnishings'           =>  'Text',
        */

        if (!empty($this->Amenities)) {
            $this->Amenities = strip_tags($this->Amenities);
        }

        if (!empty($this->Testimonial)) {
            $this->Testimonial = strip_tags($this->Testimonial);
        }

        if (!empty($this->Furnishings)) {
            $this->Furnishings = strip_tags($this->Furnishings);
        }

        if (!empty($this->Content)) {
            $this->Content = strip_tags($this->Content);
        }

        $this->ShowInMenus = false;
    }

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Lister'            =>  'Member',
        'ListerAgency'      =>  'Agency'
    );

    /**
     * Has_many relationship
     * @var array
     */
    private static $has_many = array(
        'Gallery'           =>  'Image'
    );

    public function hasPaid()
    {
        if ($orders = $this->Orders()) {
            if ($last_successful = $orders->filter(array('isOpen' => false))->first()) {
                if (!$this->ListTilGone) {
                    $today  =   date_create(date("Y-m-d"));
                    $until  =   date_create($last_successful->ValidUntil);
                    if ($until >= $today) {
                        return true;
                    }
                } elseif (!$this->isGone && $this->isPaid) {
                    return true;
                }
            }

        }

        return false;
    }

    public function Orders()
    {
        if (empty($this->ID)) {
            return null;
        }

        $OrderClass = SaltedPayment::get_default_order_class();
        return $OrderClass::get()->filter(array('PaidToClassID' => $this->ID));
    }

    public function Member()
    {
        return $this->Lister();
    }
}

class PropertyPage_Controller extends Page_Controller
{
    /**
     * Defines methods that can be called directly
     * @var array
     */
    private static $allowed_actions = array(
        'ContactForm'
    );

    public function getPropType()
    {
        $options = Config::inst()->get('PropertyPage', $this->RentOrSale == 'rent' ? 'RentForm' : 'SaleForm');
        $idx = !empty($this->PropertyType) ? $this->PropertyType : 0;
        return $options[$idx];
    }

    public static function translateType($name, $type)
    {
        $options = Config::inst()->get('PropertyPage', $type);
        return $options[$name];
    }

    public function getParkingOption()
    {
        $idx = !empty($this->Parking) ? $this->Parking : 0;
        $options = Config::inst()->get('PropertyPage', 'Parking');
        return $options[$idx];
    }

    public function getTenantOption()
    {
        $idx = !empty($this->IdealTenants) ? $this->IdealTenants : 0;
        $options = Config::inst()->get('PropertyPage', 'IdealTenants');
        return $options[$idx];
    }

    public function ContactForm()
    {
        return new ContactForm($this, $this->ListerID);
    }

    public function Friendlify($string)
    {
        if (!empty($string)) {
            $string = str_replace("\n", '<br />', $string);
        }
        return $string;
    }
}

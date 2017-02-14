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
        'ListingDuration'       =>  'Int',
        'ListingCloseOn'        =>  'Date',
        'LandArea'              =>  'Int',
        'FloorArea'             =>  'Int',
        'BeenRented'            =>  'Boolean'
    );

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
                TextField::create('StreetNumber', 'Street number'),
                TextField::create('StreetName', 'Street'),
                TextField::create('Suburb', 'Suburb'),
                TextField::create('City', 'City'),
                TextField::create('Region', 'Region'),
                TextField::create('Country', 'Country'),
                TextField::create('PostCode', 'Post code'),
                TextField::create('Lat', 'Latitude'),
                TextField::create('Lng', 'Longitude'),
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
                $today  =   date_create(date("Y-m-d"));
                $until  =   date_create($last_successful->ValidUntil);
                if ($until >= $today) {
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
}

class PropertyPage_Controller extends Page_Controller
{

}

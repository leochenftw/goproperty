<?php
use SaltedHerring\Debugger;
use SaltedHerring\SaltedPayment;
use SaltedHerring\Grid;
use Cocur\Slugify\Slugify;

class Business extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Title'         =>  'Varchar(256)',
        'ContactNumber' =>  'Varchar(24)',
        'Content'       =>  'Text',
        'ListLength'    =>  'Enum(array("6 months","1 year"), "6 months")',
        'Listed'        =>  'Boolean'
    );

    private static $extensions = array(
        'AddressProperties',
        'SlugExtension'
    );

    /**
     * Belongs_to relationship
     * @var array
     */
    private static $belongs_to = array(
        'Member'        =>  'Member'
    );


    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Logo'          =>  'Image',
        'BusinessOwner' =>  'Member'
    );

    private static $has_many = array(
        'Interests'     =>  'Interest',
        'Appointments'  =>  'Appointment'
    );

    /**
     * Many_many relationship
     * @var array
     */
    private static $many_many = array(
        'Services'  =>  'Service'
    );

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
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

        if (!empty($this->Orders())) {
            $fields->addFieldToTab(
                'Root.Orders',
                Grid::make('Orders', 'Orders', $this->Orders(), false)
            );
        }
        return $fields;
    }

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
        return $OrderClass::get()->filter(array('PaidToClass' => 'Business', 'PaidToClassID' => $this->ID));
    }

    public function ValidUntil()
    {
        if ($orders = $this->Orders()) {
            if ($last_successful = $orders->filter(array('isOpen' => false))->first()) {
                return $last_successful->ValidUntil;
            }
        }
    }

    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->ID)) {
            $this->BusinessOwnerID = Member::currentUserID();
        }
        if (!empty($this->Content)) {
            $this->Content = strip_tags($this->Content);
        }
    }

    public function Friendlify($string)
    {
        if (!empty($string)) {
            $string = str_replace("\n", '<br />', $string);
        }
        return $string;
    }

    public function Link()
    {
        $slugify = new Slugify();
        return Director::baseURL() . 'tradesmen/' . (!empty($this->Region) ? $slugify->slugify($this->Region) . '/' : 'all-region/') . (!empty($this->City) ? $slugify->slugify($this->City) . '/' : 'all-district/') . (!empty($this->Suburb) ? $slugify->slugify($this->Suburb) . '/' : 'all-suburb/') . $this->Slug;
    }

    public function isWished()
    {
        if ($member = Member::currentUser()) {
            $wtf = $member->Wishlist()->filter(array('TargetClass' => $this->ClassName, 'TargetID' => $this->ID))->count() > 0;
            // Debugger::inspect($wtf ? 'yes' : 'no');
            return $wtf;
        }
        return false;
    }

    public function getComments()
    {
        $comments                       =   array();
        if ($this->Member()->Rate()->exists()) {

            $received = $this->Member()->Rate()->where('"Rating"."Key" IS NULL')->distinct('"Rating"."ID"');

            $total = $received->count() * 5;

            if ($total > 0) {
                foreach ($received as $rating) {
                    if (!$this->searchArray($rating->ID, $comments)) {
                        $comment_item = array(
                            'ID'        =>  $rating->ID,
                            'Member'    =>  $rating->Giver(),
                            'Comment'   =>  $rating->Comment,
                            'When'      =>  $rating->Created,
                            'Stars'     =>  $rating->Stars
                        );
                        $comments[]     =   $comment_item;
                    }
                }

            }
        }

        return new ArrayList($comments);
    }

    public function searchArray($ID, &$comments)
    {
        foreach ($comments as $comment)
        {
            if ($comment['ID'] == $ID) {
                return true;
            }
        }

        return false;
    }
}

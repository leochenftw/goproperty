<?php use SaltedHerring\Debugger;

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
        'WeeklyRent'        =>  'Decimal',
        'DateAvailable'     =>  'Date',
        'ContactNumber'     =>  'Varchar(24)',
        'NumBedrooms'       =>  'Int',
        'NumBathrooms'      =>  'Int',
        'Amenities'         =>  'Text',
        'Testimonial'       =>  'Text',
        'AllowPet'          =>  'Enum("No,Yes,Negotiable")',
        'AllowSmoker'       =>  'Enum("No,Yes")',
        'Furnishings'       =>  'Text',
        'InTheArea'         =>  'Text',
        'Parking'           =>  'Varchar(64)',
        'IdealTenants'      =>  'Varchar(64)',
        'MaxCapacity'       =>  'Int'
    );

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        $this->Title = $this->FullAddress;
        $parent = PropertyListingPage::get()->first();
        if (!empty($parent)) {
            $this->ParentID = $parent->ID;
        }
    }

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Lister'            =>  'Member'
    );

    /**
     * Has_many relationship
     * @var array
     */
    private static $has_many = array(
        'Gallery'           =>  'Image'
    );

}

class PropertyPage_Controller extends Page_Controller
{

}

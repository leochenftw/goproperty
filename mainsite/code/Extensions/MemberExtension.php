<?php
use SaltedHerring\Debugger;
use SaltedHerring\Grid;
use SaltedHerring\SaltedPayment;

class MemberExtension extends DataExtension
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'ValidationKey'  	 	=>	'Varchar(40)',
        'ContactNumber'         =>  'Varchar(24)'
    );
    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Portrait'              =>  'Portrait'
    );

    /**
     * Belongs_many_many relationship
     * @var array
     */
    private static $belongs_many_many = array(
        'MemberOf'              =>  'Agency'
    );

    public function populateDefaults()
    {
        $this->owner->ValidationKey = sha1(mt_rand() . mt_rand());
    }
    /**
     * Update Fields
     * @return FieldList
     */
    public function updateCMSFields(FieldList $fields)
    {
        $fields->removeByName('PortraitID');
        $fields->addFieldsToTab(
            'Root.Portrait',
            array(
                LiteralField::create('PortraitID', '<h2>' . $this->owner->PortraitID . '</h2>'),
                LiteralField::create('CropboxX', '<h3>Cropbox X: ' . $this->owner->Portrait()->CropperX . '</h3>'),
                LiteralField::create('CropboxY', '<h3>Cropbox Y: ' . $this->owner->Portrait()->CropperY . '</h3>'),
                LiteralField::create('CropboxWidth', '<h3>Cropbox Width: ' . $this->owner->Portrait()->CropperWidth . '</h3>'),
                LiteralField::create('CropboxHeight', '<h3>Cropbox Height: ' . $this->owner->Portrait()->CropperHeight . '</h3>'),

                LiteralField::create('Image', $this->owner->Portrait()->Image()->FillMax(400, 400))
            )
        );

        if ($this->Orders()->count() > 0) {
            $fields->addFieldToTab(
                'Root.Orders',
                // Grid::make('Payments', 'Payments', $this->Payments(), false, 'GridFieldConfig_RecordViewer')
                Grid::make('Orders', 'Orders', $this->Orders(), false)
            );
        }

        return $fields;
    }
    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->owner->PortraitID)) {
            $portrait = new Portrait();
            $id = $portrait->write();
            $this->owner->PortraitID = $id;
        }
    }

    public function Orders()
    {
        if (empty($this->owner->ID)) {
            return null;
        }

        $OrderClass = SaltedPayment::get_default_order_class();
        return $OrderClass::get()->filter(array('PaidToClassID' => $this->owner->ID));
    }

    public function onSaltedPaymentUpdate($success)
    {
        if ($success) {
            $this->owner->addToGroupByCode('tradesmen', 'Tradesmen');
        }
    }

    public function isAgent()
    {
        return $this->owner->inGroup('tradesmen');
    }

    public function getPaymentHistory()
    {
        // if ($payment = $this->Payments()) {
        //     return $payment->filter(array('Status:not' => 'Pending'));
        // }
        // return null;
    }

    public function getSubscription()
    {
        // if ($payment = Payment::get()->filter(array('OrderID' => $this->owner->ID, 'OrderClass' => 'Member'))) {
        //     return $payment->filter(array('Status' => 'Pending', 'ScheduleFuturePay' => true, 'NextPayDate:GreaterThanOrEqual' => date("Y-m-d")))->first();
        // }
        // return null;
    }

    public function getActiveSubscription()
    {
        // if ($payment = Payment::get()->filter(array('OrderID' => $this->owner->ID, 'OrderClass' => 'Member'))) {
        //     return $payment->filter(array('Status' => 'Success', 'ProcessedAt:LessThanOrEqual' => date("Y-m-d H:i:s")))->first();
        // }
        // return null;
    }

}

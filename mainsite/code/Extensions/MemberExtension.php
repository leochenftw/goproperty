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
        'ContactNumber'         =>  'Varchar(24)',
        'beLandlords'           =>  'Boolean',
        'beTradesmen'           =>  'Boolean',
        'beRealtors'            =>  'Boolean'
    );

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Portrait'              =>  'Portrait',
        'Business'              =>  'Business'
    );

    /**
     * Has_many relationship
     * @var array
     */
    private static $has_many = array(
        'Rate'                  =>  'Rating.Giver',
        'BeingRated'            =>  'Rating.Taker'
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
        return $this->owner->inGroup('realtors');
    }


    public function isLandlord()
    {
        return $this->owner->inGroup('landlords');
    }

    public function isTradesperson()
    {
        return $this->owner->inGroup('tradesmen');
    }

    public function isRealtor()
    {
        return $this->owner->isAgent();
    }

    public function getPaymentHistory()
    {
        if ($payment = $this->owner->Orders()) {
            return $payment->filter(array('isOpen' => false));
        }
        return null;
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

    public function getTitle()
    {
        return $this->owner->FirstName . (!empty($this->owner->Surname) ? (' ' . $this->owner->Surname) : '');
    }

    public function Title()
    {
        return $this->getTitle();
    }

    public function getRating($asHTML = false)
    {
        if ($this->owner->BeingRated()->exists()) {
            $received = $this->owner->BeingRated();
            $total = $received->count() * 5;
            $actual = 0;
            foreach ($received as $rating) {
                $actual += $rating->Stars;
            }

            $n = ($actual / $total) * 5;
            if ($asHTML) {
                return $this->ratingHTML($n);
            }

            return $n;
        }

        return !$asHTML ? 0 : $this->ratingHTML(0);
    }

    private function ratingHTML($n)
    {
        $arr = array();
        $i = floor($n);
        for ($j = 0; $j < 5; $j++) {
            $arr[] = '<li data-stars="' . ($j+1) . '" class="' . ($j < $i ? 'icon-star' : 'icon-star-empty') . '"></li>';
        }

        if ($n == 0) {
            $arr[0] = '<li data-stars="1" class="icon-star-empty"></li>';
        } elseif ($n - $i > 0 ) {
            $arr[$i] = '<li data-stars="' . $i . '" class="icon-star-half"></li>';
        }

        return implode("\n", $arr);
    }

}

<?php
use SaltedHerring\Debugger;
use SaltedHerring\Utilities;
use SaltedHerring\Grid;
use SaltedHerring\SaltedPayment;

class MemberExtension extends DataExtension
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Nickname'              =>  'Varchar(32)',
        'NameToUse'             =>  'Enum("Real name,Nickname")',
        'DisplayPhonenumber'    =>  'Boolean',
        'ValidationKey'  	 	=>	'Varchar(40)',
        'ContactNumber'         =>  'Varchar(24)',
        'MobileNumber'          =>  'Varchar(24)',
        // 'beLandlords'           =>  'Boolean',
        // 'beTradesmen'           =>  'Boolean',
        // 'beRealtors'            =>  'Boolean',
        'FreeUntil'             =>  'Date',
        'ChangePassOnNextLogin' =>  'Boolean',
        'SignupFrom'            =>  'Varchar(2048)'
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
        'BeingRated'            =>  'Rating.Taker',
        'Wishlist'              =>  'WishlistItem',
        'Properties'            =>  'Property'
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

        if (!empty($this->Orders()) && $this->Orders()->count() > 0) {
            $fields->addFieldToTab(
                'Root.Orders',
                // Grid::make('Payments', 'Payments', $this->Payments(), false, 'GridFieldConfig_RecordViewer')
                Grid::make('Orders', 'Orders', $this->Orders(), false)
            );
        }

        return $fields;
    }

    /**
     * Event handler called before deleting from the database.
     */
    public function onBeforeDelete()
    {
        parent::onBeforeDelete();
        $props      =   $this->owner->Properties();
        $wishlist   =   $this->owner->Wishlist();
        $rates      =   $this->owner->Rate();
        $rateds     =   $this->owner->BeingRated();
        $portrait   =   $this->owner->Portrait();
        $business   =   $this->owner->Business();

        $portrait->delete();
        $business->delete();

        foreach ($rates as $rate)
        {
            $rate->delete();
        }

        foreach ($rateds as $rated)
        {
            $rated->delete();
        }

        foreach ($wishlist as $wish)
        {
            $wish->delete();
        }

        foreach ($props as $prop)
        {
            $prop->delete();
        }

        $propages   =   Versioned::get_by_stage('PropertyPage', 'Stage')->filter(array('ListerID' => $this->owner->ID));

        foreach ($propages as $propage)
        {
            $propage->doUnpublish();
            $propage->deleteFromStage('Stage');
        }
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

        if (!empty($this->owner->Nickname)) {
            $purified = Utilities::sanitise($this->owner->Nickname, '', '');
            $this->owner->Nickname = $purified;
        }
    }

    public function AccountRelatedOrders()
    {
        if ($payment = $this->owner->Orders()) {
            return $payment->filter(array('isOpen' => false, 'PaidToClass' => 'Member'));
        }
        return null;
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

    public function getRating()
    {
        $data = array(
            'Rated'     =>  $this->owner->Rate()->filter(array('GiverID' => Member::currentUserID()))->first() ? true : false,
            'Count'     =>  0,
            'HTML'      =>  ''
        );

        $n = 0;

        if ($this->owner->BeingRated()->exists()) {
            $received = $this->owner->BeingRated();
            $data['Count'] = $received->count();
            $total = $received->count() * 5;
            $actual = 0;
            foreach ($received as $rating) {
                $actual += $rating->Stars;
            }

            $n = ($actual / $total) * 5;
        }

        $data['HTML'] = $this->ratingHTML($n);

        return new ArrayData($data);
    }
    //
    // public function getRating($asHTML = false)
    // {
    //     if ($this->owner->BeingRated()->exists()) {
    //         $received = $this->owner->BeingRated();
    //         $total = $received->count() * 5;
    //         $actual = 0;
    //         foreach ($received as $rating) {
    //             $actual += $rating->Stars;
    //         }
    //
    //         $n = ($actual / $total) * 5;
    //         if ($asHTML) {
    //             return $this->ratingHTML($n);
    //         }
    //
    //         return $n;
    //     }
    //
    //     return !$asHTML ? 0 : $this->ratingHTML(0);
    // }

    private function ratingHTML($n)
    {
        $arr = array();
        $i = floor($n);
        for ($j = 0; $j < 5; $j++) {
            $arr[] = '<li data-stars="' . ($j+1) . '" class="icon"><i class="fa fa-' . ($j < $i ? 'star' : 'star-o') . '"></i></li>';
        }

        if ($n == 0) {
            $arr[0] = '<li data-stars="1" class="icon"><i class="fa fa-star-o"></i></li>';
        } elseif ($n - $i > 0 ) {
            $arr[$i] = '<li data-stars="' . $i . '" class="icon"><i class="fa fa-star-half-o"></i></li>';
        }

        return implode("\n", $arr);
    }

    public function NeedsToPay()
    {
        if ($this->owner->beLandlords || $this->owner->beTradesmen || $this->owner->beRealtors) {
            return true;
        }

        return false;
    }

    public function getDisplayName()
    {
        if ( !empty($this->owner->Nickname) && $this->owner->NameToUse == 'Nickname' ) {
            return $this->owner->Nickname;
        }

        return $this->owner->FirstName . (!empty($this->owner->Surname) ? (' ' . $this->owner->Surname) : '');
    }

    public function TrialExpired()
    {
        if (!empty($this->owner->FreeUntil)) {
            $freeUntil = strtotime($this->owner->FreeUntil);
            return $freeUntil < time();
        }

        return true;
    }

    public function inFreeTrial()
    {
        if (!empty($this->owner->FreeUntil)) {
            $freeUntil = strtotime($this->owner->FreeUntil);
            return $freeUntil >= time();
        }
        return false;
    }

    public function getPropertyonSale()
    {
        return Versioned::get_by_stage('PropertyPage', 'Stage')->filter(array('ListerID' => $this->owner->ID, 'Tinfoiled' => false, 'RentOrSale' => 'sale'));
    }

}

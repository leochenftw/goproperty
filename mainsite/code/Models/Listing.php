<?php
use SaltedHerring\Debugger;

class Listing extends DataObject
{
    private static $db = array(
        'AgencyReference'       =>  'Varchar(64)',
        'ContactNumber'         =>  'Varchar(24)',
        'ListTilGone'           =>  'Boolean',
        'ListTilDate'           =>  'Date',
        'isGone'                =>  'Boolean',
        'isPaid'                =>  'Boolean'
    );

    private static $default_sort =  array(
        'ID'                    =>  'DESC'
    );

    private static $has_one = array(
        'Property'              =>  'Property',
        'Member'                =>  'Member',
        'Agency'                =>  'Agency'
    );

    private static $has_many = array(
        'Interests'             =>  'Interest',
        'Orders'                =>  'Order'
    );

    public function populateDefaults()
    {
        $this->MemberID         =   Member::currentUserID();
    }

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (!empty($this->ListTilGone)) {
            $this->ListTilDate = null;
        }

        if (empty($this->AgencyID)) {
            $this->AgencyReference = null;
        }
    }

    //  this returns number for payment
    public function getAmount()
    {
        if (!empty($this->ListTilGone)) {
            return Config::inst()->get('Property', 'TilRented');
        } elseif (!empty($this->ListTilDate)) {
            $today          =   date_create(date("Y-m-d"));
            $until          =   date_create($this->ListTilDate);
            $daily_charge   =   Config::inst()->get('Property', 'DailyCharge');
            if ($until >= $today) {
                $diff       =   date_diff($today,$until);
                $diff       =   $diff->days + 1;

                return $daily_charge * $diff;
            }
        }

        return 0;
    }

    // this returns dollar format for humans
    public function getAmountdue()
    {
        if (!empty($this->ListTilGone)) {
            $amount         =   Config::inst()->get('Property', 'TilRented');
            return '$' . number_format($amount, 2, '.', ',');
        } elseif (!empty($this->ListTilDate)) {
            $today          =   date_create(date("Y-m-d"));
            $until          =   date_create($this->ListTilDate);
            $daily_charge   =   Config::inst()->get('Property', 'DailyCharge');
            if ($until >= $today) {
                $diff       =   date_diff($today,$until);
                $diff       =   $diff->days + 1;

                return '$' . number_format($daily_charge * $diff, 2, '.', ',');
            }
        }

        return '-.--';
    }

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->addFieldToTab(
            'Root.Main',
            LiteralField::create(
                'isPublished',
                $this->isPublished() ? 'Published' : 'Not published'
            )
        );
        return $fields;
    }

    public function getCached()
    {

    }

    public function getStatus()
    {
        if ($this->isPaid && $this->isPublished()) {
            return 'Listing';
        }

        if ($this->isPaid && !$this->isPublished()) {
            return 'Finished';
        }

        if (!$this->isPaid && !$this->isPublished()) {
            return 'Drafting';
        }

        return '--';
    }

    public function isPublished()
    {
        return Versioned::get_by_stage('Listing', 'Live')->byID($this->ID);
    }
}

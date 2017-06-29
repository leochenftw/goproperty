<?php
/*
db
- coupon serials: varchar(16)
- used: boolean
- purpose: enum("landlord,realtor,tradesperson")
- expiry date: date

onbeforewrite
- create a randomised coupon number
- check unique

onafterwrite
- if used, upgrade account to the corresponding role
*/
class Voucher extends DataObject
{
    private static $db      =   array(
        'Serials'           =>  'Varchar(12)',
        'ExpiryDate'        =>  'Date',
        'Email'             =>  'Varchar(256)',
        'AllowGroup'        =>  'Enum("landlords,realtors,tradesmen")'
    );

    private static $summary_fields = array(
        'Serials'           =>  'Voucher number',
        'ExpiryDate'        =>  'Expiry date',
        "isUsed"            =>  'Used',
        "UsedBy"            =>  'Used by'
    );

    private static $has_one =   array(
        'Member'            =>  'Member'
    );

    public function isUsed()
    {
        return !empty($this->MemberID) ? 'Yes' : 'No';
    }

    public function UsedBy()
    {
        if (!empty($this->MemberID)) {
            return $this->Member()->FirstName . ' ' . $this->Member()->Surname;
        }
        return '-';
    }

    public function populateDefaults()
    {
        $this->Serials      =   substr(sha1(mt_rand() . mt_rand()), 0, 12);
        $this->ExpiryDate   =   date('Y-m-d',strtotime(date("Y-m-d", time()) . " + 365 day"));
    }

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->ID)) {
            $this->Serials = $this->testUnique($this->Serials);
        }
    }

    /**
     * Event handler called after writing to the database.
     */
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        if (!empty($this->Email)) {
            $email = new VoucherGiverEmail($this);
            $email->send();
        }
    }

    private function testUnique($Serials)
    {
        $test               =   Voucher::get()->filter(array('Serials' => $Serials))->count();

        if ($test > 0) {
            $new_serials    =   substr(sha1($Serials), 0, 12);
            return $this->testUnique($new_serials);
        }
        return $Serials;
    }
}

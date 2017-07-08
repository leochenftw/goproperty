<?php

use SaltedHerring\Debugger;

class SaleListing extends Listing
{
    private static $db = array(
        'RateableValue'         =>  'Decimal',
        'HideRV'                =>  'Boolean',
        'ExpectdSalePrice'      =>  'Decimal',
        'OpenHomeFrequency'     =>  'Enum("On,Every,Upon request")',
        'OpenHomeDays'          =>  'Enum("Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday")',
        'OpenHomeTimes'         =>  'SS_Datetime',
        'PriceOption'           =>  'Varchar(48)',
        'AskingPrice'           =>  'Decimal',
        'EnquiriesOver'         =>  'Decimal',
        'AuctionOn'             =>  'Date',
        'TenderCloseOn'         =>  'Date',
        'PriceByNegotiation'    =>  'Boolean',
        'PrivateTreatyDeadline' =>  'Date'

    );

    public function getListTil()
    {
        if (empty($this->ListTilGone)) {
            return $this->ListTilDate;
        }

        return 'sold';
    }

    public function getStatus()
    {
        if ($this->isGone) {
            return 'Sold';
        }

        return parent::getStatus();
    }

}

<?php

use SaltedHerring\Debugger;

class SaleListing extends Listing
{
    private static $db = array(
        'RateableValue'         =>  'Decimal',
        'HideRV'                =>  'Boolean',
        'ExpectdSalePrice'      =>  'Decimal',
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

        return 'Property is sold';
    }

    public function getStatus()
    {
        if ($this->isGone) {
            return 'Sold';
        }

        return parent::getStatus();
    }

}

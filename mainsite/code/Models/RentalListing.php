<?php

use SaltedHerring\Debugger;
use SaltedHerring\SaltedCache;
use SaltedHerring\Utilities;

class RentalListing extends Listing
{
    private static $db = array(
        'WeeklyRent'            =>  'Decimal',
        'DateAvailable'         =>  'Date',
        'AllowPet'              =>  'Enum("No,Yes,Negotiable")',
        'AllowSmoker'           =>  'Enum("No,Yes")',
        'Furnishings'           =>  'Text',
        'IdealTenants'          =>  'Varchar(64)'
    );

    public function getListTil()
    {
        if (empty($this->ListTilGone)) {
            return $this->ListTilDate;
        }

        return 'rented';
    }

    /**
     * Event handler called after writing to the database.
     */
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $this->getCached();
    }

    public function getCached()
    {
        $factory                    =   'Property';
        $key                        =   $this->ID . '_' . $this->LastEdited . '_' . $this->Property()->LastEdited;
        $key                        =   str_replace('-', '_',  Utilities::sanitise($key));
        $property                   =   SaltedCache::read($factory, $key);

        if (empty($property)) {
            $property_entity        =   $this->Property();
            $property               =   array(
                'Property'          =>  $property_entity,
                'WeeklyRent'        =>  $this->WeeklyRent,
                'DateAvailable'     =>  $this->DateAvailable,
                'AllowPet'          =>  $this->AllowPet,
                'AllowSmoker'       =>  $this->AllowSmoker,
                'Furnishings'       =>  $this->Furnishings,
                'IdealTenants'      =>  $this->IdealTenants,
                'AgencyReference'   =>  $this->AgencyReference,
                'ContactNumber'     =>  $this->ContactNumber
            );
            SaltedCache::save($factory, $key, $property);
        }

        return $property;
    }

    public function getStatus()
    {
        if ($this->isGone) {
            return 'Rented';
        }

        return parent::getStatus();
    }

}

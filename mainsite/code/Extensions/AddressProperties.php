<?php use SaltedHerring\Debugger;

class AddressProperties extends DataExtension
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'FullAddress'       =>  'Text',
        'StreetNumber'      =>  'Varchar(8)',
        'StreetName'        =>  'Varchar(512)',
        'City'              =>  'Varchar(128)',
        'Region'            =>  'Varchar(128)',
        'Country'           =>  'Varchar(128)',
        'Lat'               =>  'Varchar(64)',
        'Lng'               =>  'Varchar(64)'
    );
}

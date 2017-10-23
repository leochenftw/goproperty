<?php

class Click extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = [
        'IP'    =>  'Varchar(16)',
        'Agent' =>  'Varchar(512)'
    ];

    /**
     * Defines summary fields commonly used in table columns
     * as a quick overview of the data for this dataobject
     * @var array
     */
    private static $summary_fields = [
        'IP'    =>  'IP address'
    ];

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = [
        'Ads'   =>  'Ads'
    ];
}

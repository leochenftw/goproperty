<?php

class Service extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Title'     =>  'Varchar(128)'
    );

    private static $extensions = array(
        'SlugExtension'
    );

    /**
     * Defines summary fields commonly used in table columns
     * as a quick overview of the data for this dataobject
     * @var array
     */
    private static $summary_fields = array(
        'Title',
        'Slug'
    );

    /**
     * Belongs_many_many relationship
     * @var array
     */
    private static $belongs_many_many = array(
        'Business'  =>  'Business'
    );
}

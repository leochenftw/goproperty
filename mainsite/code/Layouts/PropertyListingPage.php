<?php

class PropertyListingPage extends Page
{
    /**
     * Defines the allowed child page types
     * @var array
     */
    private static $allowed_children = array(
        'PropertyPage'
    );
    /**
     * Creating Permissions
     * @return boolean
     */
    public function canCreate($member = null)
    {
        if (PropertyListingPage::get()->count() > 0) {
            return false;
        }
        return true;
    }

}

class PropertyListingPage_Controller extends Page_Controller
{

}

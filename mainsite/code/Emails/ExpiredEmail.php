<?php
/**
 * An email sent to the user with a link to validate and activate their account.
 *
 * @package silverstripe-memberprofiles
 */
class ExpiredEmail extends Email
{

    public function __construct($member) {
        $from     =    Config::inst()->get('Email', 'noreply_email');
        $to       =    $member->Email;
        $subject  =    '[' . SiteConfig::current_site_config()->Title . '] - Your free trial has expired';

        parent::__construct($from, $to, $subject);

        $this->setTemplate('ExpiredEmail');

        $this->populateTemplate(new ArrayData(
                 array (
                    'baseURL'   =>  Director::absoluteURL(Director::baseURL()),
                    'Member'    =>  $member
                )
             ));
    }
}

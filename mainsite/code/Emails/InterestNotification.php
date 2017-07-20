<?php
/**
 * An email sent to the user with a link to validate and activate their account.
 *
 * @package silverstripe-memberprofiles
 */
class InterestNotification extends Email
{

	public function __construct($member, $type) {
		$from     =    Config::inst()->get('Email', 'noreply_email');
		$to       =    $member->Email;
		$subject  =    '[' . SiteConfig::current_site_config()->Title . '] - enquiry notification';

		parent::__construct($from, $to, $subject);

		$this->setTemplate('InterestNotification');

		$this->populateTemplate(new ArrayData(
			 	array (
					'baseURL'      =>  Director::absoluteURL(Director::baseURL()),
					'ContentTitle' =>  $subject,
                    'Member'       =>  $member,
                    'Thing'        =>  $type == 'business' ? 'business' : 'property',
                    'Link'         =>  Director::absoluteURL(Controller::join_links (
                    						Controller::join_links(Director::baseURL(), 'member', 'action', 'my-' . $type)
                    					))
				)
			 ));
	}
}

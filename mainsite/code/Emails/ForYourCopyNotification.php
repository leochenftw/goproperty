<?php
/**
 * An email sent to the user with a link to validate and activate their account.
 *
 * @package silverstripe-memberprofiles
 */
class ForYourCopyNotification extends Email
{

	public function __construct($member, $title, $url, $message) {
		$from     =    Config::inst()->get('Email', 'noreply_email');
		$to       =    $member->Email;
		$subject  =    '[' . SiteConfig::current_site_config()->Title . '] - a copy of your message';

		parent::__construct($from, $to, $subject);

		$this->setTemplate('ForYourCopyNotification');

		$this->populateTemplate(new ArrayData(
			 	array (
					'baseURL'      =>  Director::absoluteURL(Director::baseURL()),
					'Title'        =>  $title,
                    'Message'      =>  $message,
                    'Link'         =>  Director::absoluteURL(Controller::join_links (
                    						Controller::join_links(Director::baseURL(), $url)
                    					))
				)
			 ));
	}
}

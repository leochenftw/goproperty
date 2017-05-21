<?php
/**
 * An email sent to the user with a link to validate and activate their account.
 *
 * @package silverstripe-memberprofiles
 */
class FeedbackInvitation extends Email
{

	public function __construct($member, $role, $rating_object) {
		$from     =    Config::inst()->get('Email', 'noreply_email');
		$to       =    $member->Email;
		$subject  =    '[' . SiteConfig::current_site_config()->Title . '] ' . $role . ' - provide feedback';

		parent::__construct($from, $to, $subject);

		$this->setTemplate('FeedbackInvitation');

		$this->populateTemplate(new ArrayData(
			 	array (
					'baseURL'      =>  Director::absoluteURL(Director::baseURL()),
					'ContentTitle' =>  $subject,
                    'Member'       =>  $member,
                    'Link'         =>  Director::absoluteURL(Controller::join_links (
						Controller::join_links(Director::baseURL(), 'feedback', $rating_object->ID),
						"?key=$rating_object->Key"
					))
				)
			 ));
	}
}

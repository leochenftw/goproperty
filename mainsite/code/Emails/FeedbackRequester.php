<?php
/**
 * An email sent to the user with a link to validate and activate their account.
 *
 * @package silverstripe-memberprofiles
 */
class FeedbackRequester extends Email
{

	public function __construct($email, $rating_object) {
		$from     =    Config::inst()->get('Email', 'noreply_email');
		$to       =    $email;
		$subject  =    '[' . SiteConfig::current_site_config()->Title . '] You are invited to provide feedback';

		parent::__construct($from, $to, $subject);

		$this->setTemplate('FeedbackRequester');

		$this->populateTemplate(new ArrayData(
			 	array (
					'baseURL'      =>  Director::absoluteURL(Director::baseURL()),
					'ContentTitle' =>  $subject,
                    'Link'         =>  Director::absoluteURL(Controller::join_links (
						Controller::join_links(Director::baseURL(), 'feedback', $rating_object->ID),
						"?key=$rating_object->Key"
					))
				)
			 ));
	}
}

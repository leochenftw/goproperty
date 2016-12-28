<?php
/**
 * An email sent to the user with a link to validate and activate their account.
 *
 * @package silverstripe-memberprofiles
 */
class ConfirmationEmail extends Email {

	/**
	 * The default confirmation email subject if none is provided.
	 *
	 * @var string
	 */
	const DEFAULT_SUBJECT = '$SiteName Member Activation';

	/**
	 * The default email template to use if none is provided.
	 *
	 * @var string
	 */
	const DEFAULT_TEMPLATE = '
<p>
	Dear $Member.Email,
</p>

<p>
	Thank you for registering at $SiteName! In order to use your account you must first confirm your
	email address by clicking on the link below. Until you do this you will not be able to log in.
</p>

<h3>Account Confirmation</h3>

<p>
	Please <a href="$ConfirmLink">confirm your email</a>, or copy and paste the following URL into
	your browser to confirm this is your real email address:
</p>

<pre>$ConfirmLink</pre>

<p>
	If you were not the person who signed up using this email address, please ignore this email. The
	user account will not become active.
</p>

<h3>Log-In Details</h3>

<p>
	Once your account has been activated you will automatically be logged in. You can also log in
	<a href="$LoginLink">here</a>. If you have lost your password you can generate a new one
	on the <a href="$LostPasswordLink">lost password</a> page.
</p>
';

	/**
	 * A HTML note about what variables will be replaced in the subject and body fields.
	 *
	 * @var string
	 */
	const TEMPLATE_NOTE = '
<p>
	The following special variables will be replaced in the email template and subject line:
</p>

<ul>
	<li>$SiteName: The name of the site from the default site configuration.</li>
	<li>$ConfirmLink: The link to confirm the user account.</li>
	<li>$LoginLink: The link to log in with.</li>
	<li>$LostPasswordLink: A link to the forgot password page.</li>
	<li>
		$Member.(Field): Various fields to do with the registered member. The available fields are
		Name, FirstName, Surname, Email, and Created.
	</li>
</ul>
';

	/**
	 * Replaces variables inside an email template according to {@link TEMPLATE_NOTE}.
	 *
	 * @param string $string
	 * @param Member $member
	 * @return string
	 */
	public static function get_parsed_string($string, $member) {
		$variables = array (
			'$SiteName'       => SiteConfig::current_site_config()->Title,
			'$LoginLink'      => Director::absoluteURL(singleton('Security')->Link('login')),
			'$ConfirmLink'    => Director::absoluteURL(Controller::join_links (
				Controller::join_links(Director::baseURL(), 'signup', 'activate'),
				"?id=$member->ID&token={$member->ValidationKey}"
			)),
			'$LostPasswordLink' => Director::absoluteURL(singleton('Security')->Link('lostpassword')),
			'$Member.Created'   => $member->obj('Created')->Nice()
		);

		foreach(array('Name', 'FirstName', 'Surname', 'Email') as $field) {
			$variables["\$Member.$field"] = $member->$field;
		}

		return str_replace(array_keys($variables), array_values($variables), $string);
	}

	public function __construct($member, $from = null) {
		$from    = $from ? $from : 'no-reply@nzyogo.co.nz';
		$to      = $member->Email;
		$subject = self::get_parsed_string(self::DEFAULT_SUBJECT, $member);

		parent::__construct($from, $to, $subject);

		$this->setTemplate('NewAccount');

		$this->populateTemplate(new ArrayData(
			 	array (
					'baseURL'		=>	Director::absoluteURL(Director::baseURL()),
					'Sitename'		=>	SiteConfig::current_site_config()->Title,
					'Member'		=>	$member,
					'ConfirmLink'	=>	Director::absoluteURL(Controller::join_links (
						Controller::join_links(Director::baseURL(), 'signup', 'activate'),
						"?id=$member->ID&token={$member->ValidationKey}"
					))
				)
			 ));
	}
}

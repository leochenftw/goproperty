<?php use SaltedHerring\Debugger as Debugger;
/**
 *
 * */
class SigninForm extends MemberLoginForm {

	public function __construct($controller, $name) {
		parent::__construct($controller, $name);

		$fields = parent::Fields();

		$this->setFormMethod('POST',true);
		$this->setFormAction(Controller::join_links(BASE_URL, "signin", "SigninForm"));
	}

	private static $allowed_actions = array(
		'dologin'
	);

	public function dologin($data) {
        Session::clear('Message');
        $email = $data['Email'];
        if ($member = Member::get()->filter('Email', $email)->first()) {
            if (!empty($member->ValidationKey)) {
                $this->sessionMessage('You need to activate your account first.', 'bad');
                return $this->controller->redirectBack();
            }
        }
         if($this->performLogin($data)) {
             $this->logInUserAndRedirect($data);
         } else {
             if(array_key_exists('Email', $data)){
                 Session::set('SessionForms.MemberLoginForm.Email', $data['Email']);
                 Session::set('SessionForms.MemberLoginForm.Remember', isset($data['Remember']));
             }

			 $this->sessionMessage('Sign in failed. Incorrect email or password. If you forgot your credential, you may <a href="/Security/lostpassword">reset your password</a>.', 'bad', false);

             if(isset($_REQUEST['BackURL'])) $backURL = $_REQUEST['BackURL'];
             else $backURL = null;

             if($backURL) Session::set('BackURL', $backURL);

             // Show the right tab on failed login
             $loginLink = Director::absoluteURL('/signin');
             if($backURL) $loginLink .= '?BackURL=' . urlencode($backURL);
             $this->controller->redirect($loginLink);
         }
	}
}

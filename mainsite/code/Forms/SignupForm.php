<?php
use SaltedHerring\Debugger;
use SaltedHerring\Recaptcha;

class SignupForm extends Form {

	public function __construct($controller) {

		$fields = new FieldList();
		$fields->push($email = EmailField::create('Email', 'Email'));
		$fields->push($pass = ConfirmedPasswordField::create('Password', 'Password'));
		$fields->push($tnc = CheckboxField::create('AgreeToTnC', 'I have read and accept the <a target="_blank" href="/terms-and-conditions">terms and conditions</a> and the <a target="_blank" href="/privacy-policy">privacy policy</a>'));

		$fields->push(CheckboxField::create('Subscribe', 'Subcribe to the newsletter')->setValue(true));
		$actions = new FieldList(
			$btnSubmit = FormAction::create('doSignup','Sign up')
		);

        $btnSubmit->addExtraClass('g-recaptcha');
        $btnSubmit->setAttribute('data-sitekey', Config::inst()->get('GoogleAPIs','Recaptcha_site'))->setAttribute('data-callback', 'recaptchaHandler')->setValue(null);

		$required_fields = array(
			'Email',
			'Password',
			'AgreeToTnC'
			//'Surname',
			//'FirstName'
		);

		$required = new RequiredFields($required_fields);

		parent::__construct($controller, 'SignupForm', $fields, $actions, $required);
		$this->setFormMethod('POST', true)
			 ->setFormAction(Controller::join_links(BASE_URL, $controller->Link(), "SignupForm"));
	}

	public function doSignup($data, $form) {
        Session::clear('Message');
		if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID') && !empty($data['g-recaptcha-response'])) {
            $response = Recaptcha::verify($data['g-recaptcha-response']);
            if ($response->success) {

                if (!SaltedHerring\Utilities::valid_email($data['Email'])) {
    				$form->addErrorMessage('Email', '"' . $data['Email'] . '"Not a valid email address', "bad");
    				return Controller::curr()->redirectBack();
    			}

    			$member_exists = Member::get()->filter(array('Email' => $data['Email']));
    			if (empty($member_exists->count())) {
    				$check = $this->PassCheck($data['Email'], $data['Password']['_Password']);

    				if ($check['status']) {
    					$customer = new Member();
    					$form->saveInto($customer);
    					$customer->write();

    					$this->sessionMessage('Thank you for signing up! We have sent you an activation email to you. Please follow the instruction and activate your account.', 'good');
    				} else {
    					$messages = $check['messages'];
    					$refined_message = '';
    					foreach ($messages as $message) {
    						$refined_message .= $message . "; ";
    					}
    					$this->sessionMessage(rtrim($refined_message, '; '), 'bad');
    				}
    			} else {
    				$form->addErrorMessage('Email', '"' . $data['Email'] . '" already exists. <a href="/Security/lostpassword">Really?</a>', "bad", false);
    			}
            } else {
                $this->sessionMessage('Session validation failed. Please try again.', 'bad');
            }

            return Controller::curr()->redirectBack();

		}

		return Controller::curr()->httpError(400);
	}

    private function PassCheck($user_name, $pass) {
		$status = true;
		$message = array();
		if ($user_name == $pass) {
			$status = false;
			$message[] = 'Email and password cannot be the same!';
		}

		if (strlen($pass) < 6) {
			$status = false;
			$message[] = "Password too short!";
		}

		if (!preg_match("#[0-9]+#", $pass)) {
			$status = false;
			$message[] = "Password must include at least one number!";
		}

		if (!preg_match("#[a-zA-Z]+#", $pass)) {
			$status = false;
			$message[] = "Password must include at least one letter!";
		}
		return array('status' => $status, 'messages' => $message);
	}
}

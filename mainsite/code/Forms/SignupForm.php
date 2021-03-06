<?php
use SaltedHerring\Debugger;
use SaltedHerring\Recaptcha;

class SignupForm extends Form {

    public function __construct($controller) {

        $fields = new FieldList();
        $fields->push($email = EmailField::create('Email', 'Email'));
        $fields->push($pass = ConfirmedPasswordField::create('Password', 'Password'));
        // $fields->push($type = CheckboxSetField::create(
        //     'SignupToBe',
        //     'Account type',
        //     array(
        //         'beLandlords'           =>  'Landlords',
        //         'beTradesmen'           =>  'Tradesmen',
        //         'beRealtors'            =>  'Realtors'
        //     )
        // ));

        // $type->addExtraClass('hide');

        if ($preset_email = $controller->request->getVar('email')) {
            $email->setValue($preset_email);
        }

        if ($controller->request->getVar('BackURL')) {
            $fields->push(HiddenField::create('SignupFrom', 'SignupFrom', $controller->request->getVar('BackURL')));
        }

        $fields->push($tnc = CheckboxField::create('AgreeToTnC', 'I have read and accept the <a target="_blank" href="/terms-and-conditions">terms and conditions</a> and the <a target="_blank" href="/trust-and-safety">privacy policy</a>'));

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

        if (!empty($preset_email)) {
            $this->sessionMessage('Please sign up to give feedback', 'is-info');
        }

        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, $controller->Link(), "SignupForm"));
    }

    public function doSignup($data, $form) {
        Session::clear('Message');
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID') && !empty($data['g-recaptcha-response'])) {
            $response = Recaptcha::verify($data['g-recaptcha-response']);
            if ($response->success) {

                if (!SaltedHerring\Utilities::valid_email($data['Email'])) {
                    $form->addErrorMessage('Email', '"' . $data['Email'] . '"Not a valid email address', "is-danger");
                    return Controller::curr()->redirectBack();
                }

                $member_exists = Member::get()->filter(array('Email' => $data['Email']));
                if (empty($member_exists->count())) {
                    $check = $this->PassCheck($data['Email'], $data['Password']['_Password']);

                    if ($check['status']) {
                        $member = new Member();
                        $form->saveInto($member);
                        if (!empty(SiteConfig::current_site_config()->PromoSeason)) {
                            $member->FreeUntil = date('Y-m-d',strtotime(date("Y-m-d", time()) . " + 28 days"));
                        }
                        if (!empty($data['SignupFrom'])) {
                            $member->SignupFrom = $data['SignupFrom'] == '/member' ? '' : $data['SignupFrom'];
                        }

                        // if ($wannabe = $data['SignupToBe']) {
                        //
                        //     foreach ($wannabe as $key => $value) {
                        //         $member->$key = true;
                        //     }
                        // }

                        $member->write();
                        if (!empty(SiteConfig::current_site_config()->PromoSeason)) {
                            $member->addToGroupByCode('landlords', 'Landlords');
                            $member->addToGroupByCode('realtors', 'Realtors');
                            $member->addToGroupByCode('tradesmen', 'Tradesmen');
                        }
                        $email = new ConfirmationEmail($member);
                        $email->send();
                        $this->sessionMessage('Thank you for signing up! We have sent you an activation email to you. Please follow the instruction and activate your account.', 'is-success');
                    } else {
                        $messages = $check['messages'];
                        $refined_message = '';
                        foreach ($messages as $message) {
                            $refined_message .= $message . "; ";
                        }
                        $this->sessionMessage(rtrim($refined_message, '; '), 'is-danger');
                    }
                } else {
                    $form->addErrorMessage('Email', '"' . $data['Email'] . '" already exists. <a href="/Security/lostpassword">Really?</a>', "is-danger", false);
                }
            } else {
                $this->sessionMessage('Session validation failed. Please try again.', 'is-danger');
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

    public function getSubscription($accountType)
    {
        $prices = Config::inst()->get('Member', 'Subscriptions');
        return !empty($prices[$accountType]) ? $prices[$accountType] : 0;
    }
}

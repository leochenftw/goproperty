<?php use SaltedHerring\Debugger as Debugger;

class UpdatePasswordForm extends Form {
	public function __construct($controller) {
		$member = Member::currentUser();
		$fields = new FieldList();
		$fields->push($pass = ConfirmedPasswordField::create('Password', 'New password'));

		$actions = new FieldList(
			$btnSubmit = FormAction::create('doUpdate','Update password')
		);

        $required_fields = new RequiredFields(array('Password'));
        // Debugger::inspect(Session::get_all());
		parent::__construct($controller, 'UpdatePasswordForm', $fields, $actions, $required_fields);
		$this->setFormMethod('POST', true)
			 ->setFormAction(Controller::join_links(BASE_URL, 'member', "UpdatePasswordForm"));
	}

	public function doUpdate($data, $form) {
        // Debugger::inspect(Session::get_all());
        Session::clear('FormInfo');
		if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
			if ($member = Member::currentUser()) {

                $check = $this->PassCheck($member->Email, $data['Password']['_Password']);

                if ($check['status']) {
    				$form->saveInto($member);
                    $member->ChangePassOnNextLogin = false;
    				$member->write();
                    $this->sessionMessage('Your password has been updated.', 'is-success notification', false);
                } else {
                    $messages = $check['messages'];
                    $refined_message = '';
                    foreach ($messages as $message) {
                        $refined_message .= $message . "<br />";
                    }
                    $this->sessionMessage(rtrim($refined_message, '<br />'), 'is-danger notification', false);
                }
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
            if (strlen($pass) == 0) {
                $message[] = "Password can't be empty!";
            } else {
                $message[] = "Password too short!";
            }
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

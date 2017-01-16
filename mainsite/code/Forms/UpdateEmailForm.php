<?php use SaltedHerring\Debugger as Debugger;

class UpdateEmailForm extends Form {
	public function __construct($controller) {
		$member = Member::currentUser();
		$fields = new FieldList();
		$fields->push(LiteralField::create('CurrentEmail', '<div class="current-email">Current email address: <span>' . $member->Email . '</span></div>'));
		$fields->push($email = EmailField::create('Email', 'New email address')->setDescription('We are going to send you a validation email to the new email address. Pleaes follow the instruction in that email to finalise the changes.'));

		$actions = new FieldList(
			$btnSubmit = FormAction::create('doUpdate','Update email')
		);

		parent::__construct($controller, 'UpdateEmailForm', $fields, $actions);
		$this->setFormMethod('POST', true)
			 ->setFormAction(Controller::join_links(BASE_URL, 'member', "UpdateEmailForm"));
	}

	public function doUpdate($data, $form) {
		if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {

			if ($member = Member::currentUser()) {
				$form->saveInto($member);
				$member->write();
			}

			return Controller::curr()->redirectBack();
		}

		return Controller::curr()->httpError(400);

	}
}

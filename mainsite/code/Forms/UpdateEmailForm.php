<?php use SaltedHerring\Debugger as Debugger;

class UpdateEmailForm extends Form {
	public function __construct($controller) {
		$member = Member::currentUser();
		$fields = new FieldList();
		$fields->push(LiteralField::create('CurrentEmail', '<div class="current-email">当前邮箱地址: <span>' . $member->Email . '</span></div>'));
		$fields->push($email = EmailField::create('Email', '请输入新的邮箱地址')->setDescription('我们将发送一封验证邮件到您新的邮箱. 新邮箱地址将在验证后生效.'));
		
		$actions = new FieldList(
			$btnSubmit = FormAction::create('doUpdate','更新资料')
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
		
		return Controller::curr()->httpError(400, 'fuck off');
		
	}
}
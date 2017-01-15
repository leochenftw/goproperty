<?php
use SaltedHerring\Debugger;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;
class addCreditcardForm extends Form
{
    public function __construct($controller)
    {
        $fields = new FieldList();

        $actions = new FieldList();
        $actions->push(FormAction::create('goAdd', 'Add...'));

        parent::__construct($controller, 'addCreditcardForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', 'addCreditcardForm'))->addExtraClass('add-creditcard-form');
    }

    public function goAdd($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if ($member = Member::currentUser()) {
                $creditcard_form_link = Paystation::process(0, $member->FullRef, sha1(session_id() . '-' . round(microtime(true) * 1000)), true, false);
                $this->controller->redirect($creditcard_form_link);
                return;
            }

            $this->sessionMessage('Session expired', 'bad');
            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400);
    }
}

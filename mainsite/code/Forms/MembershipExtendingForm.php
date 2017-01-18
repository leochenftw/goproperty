<?php
use SaltedHerring\Debugger;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;

class MembershipExtendingForm extends Form
{
	public function __construct($controller)
    {
        $fields = new FieldList();

        $actions = new FieldList();
        $actions->push(FormAction::create('doExtend', 'Extend'));

        parent::__construct($controller, 'MembershipExtendingForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', 'MembershipExtendingForm'))->addExtraClass('account-upgrade-form');
    }

    public function doExtend($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if ($member = Member::currentUser()) {
                $current_active = $member->getActiveSubscription();

                $payment = new Payment();
                $payment->PaidByID = $member->ID;
                $payment->Status = 'Pending';
                $payment->NextPayDate = date('Y-m-d', strtotime($current_active->ValidUntil . ' + 1 day'));
                $payment->ValidUntil = date('Y-m-d', strtotime($current_active->ValidUntil . ' + ' . $current_active->PaymentFrequency . ' days'));
                $payment->ScheduleFuturePay = true;
                $payment->PaymentFrequency = $current_active->PaymentFrequency;
                $payment->Amount->Amount = $current_active->Amount->Amount;
                $payment->OrderClass = 'Member';
                $payment->OrderID = $member->ID;
                $payment->write();
                return $this->controller->redirectBack();
            }

            $this->sessionMessage('Session expired', 'bad');
            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400);
    }
}

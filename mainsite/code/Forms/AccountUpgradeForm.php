<?php
use SaltedHerring\Debugger;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;

class AccountUpgradeForm extends Form
{
	public function __construct($controller)
    {
        $fields = new FieldList();

        $actions = new FieldList();
        $actions->push(FormAction::create('doUpgrade', 'Upgrade now'));

        parent::__construct($controller, 'AccountUpgradeForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', 'AccountUpgradeForm'))->addExtraClass('account-upgrade-form');
    }

    public function doUpgrade($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if ($member = Member::currentUser()) {
                $payment = new Payment();
                $payment->PaidByID = $member->ID;
                $today = date("Y-m-d 00:00:00");

                $payment->ValidUntil = date('Y-m-d', strtotime($today. ' + 29 days'));
                $payment->ScheduleFuturePay = true;
                $payment->PaymentFrequency = 30;
                $payment->Amount->Amount = Config::inst()->get('Member', 'MonthlySubscription');
                $payment->OrderClass = 'Member';
                $payment->OrderID = $member->ID;
                $payment->write();
                return;
            }

            $this->sessionMessage('Session expired', 'bad');
            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400);
    }
}

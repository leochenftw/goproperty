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
                $order = SaltedOrder::prepare_order();
                $order->Amount->Amount = Config::inst()->get('Member', 'MonthlySubscription');
                $order->RecursiveFrequency = 30;
                $order->PaidToClass = 'Member';
                $order->PaidToClassID = $member->ID;
                $order->Pay('Paystation', true);
                return;
            }

            $this->sessionMessage('Session expired', 'bad');
            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400);
    }
}

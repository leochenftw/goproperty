<?php
use SaltedHerring\Debugger;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;

class AccountUpgradeForm extends Form
{
    public function __construct($controller)
    {
        $fields = new FieldList();
        $types = array(
            'Landlords'     =>  'Landlord',
            'Realtors'      =>  'Realtor',
            'Tradesmen'     =>  'Tradesperson'
        );

        if ($member = Member::currentUser()) {
            if ($member->inGroup('landlords')) {
                unset($types['Landlords']);
            }

            if ($member->inGroup('tradesmen')) {
                unset($types['Tradesmen']);
            }

            if ($member->inGroup('realtors')) {
                unset($types['Realtors']);
            }

        }

        $checked = null;

        if ($member->beLandlords) {
            $checked['Landlords'] = 'Landlords';
        }

        if ($member->beTradesmen) {
            $checked['Tradesmen'] = 'Tradesmen';
        }

        if ($member->beRealtors) {
            $checked['Realtors'] = 'Realtors';
        }

        $fields->push(CheckboxSetField::create(
            'AccountType',
            'Account type',
            $types,
            $checked
        )->addExtraClass('hide'));

        $actions = new FieldList();
        $actions->push(FormAction::create('doUpgrade', $member->NeedsToPay() ? 'Activate' : 'Upgrade now'));

        parent::__construct($controller, 'AccountUpgradeForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', 'AccountUpgradeForm'))->addExtraClass('account-upgrade-form');
    }

    public function doUpgrade($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if ($accountTypes = $data['AccountType']) {
                if ($member = Member::currentUser()) {
                    if ($member->inFreeTrial()) {
                        foreach ($accountTypes as $accountType => $value) {
                            $member->addToGroupByCode(strtolower($accountType), $accountType);
                        }
                        return $this->controller->redirect('/member/action/upgrade');
                    } else {
                        $order = SaltedOrder::prepare_order();
                        $order->Landlords = false;
                        $order->Realtors = false;
                        $order->Tradesmens = false;
                        $n = 0;
                        foreach ($accountTypes as $accountType => $value) {
                            $n += $this->getSubscription($accountType);
                            $order->$accountType = true;
                        }

                        $order->Amount->Amount = $n;
                        // $order->RecursiveFrequency = 30;
                        $order->PaidToClass = 'Member';
                        $order->PaidToClassID = $member->ID;
                        $order->Pay('Paystation');
                        return;
                    }
                }
                $this->sessionMessage('Session expired', 'bad');
            }
            $this->sessionMessage('You need to select at least one', 'bad');
            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400);
    }

    public function getSubscription($accountType)
    {
        $prices = Config::inst()->get('Member', 'Subscriptions');
        return !empty($prices[$accountType]) ? $prices[$accountType] : 0;
    }
}

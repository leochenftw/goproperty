<?php
use SaltedHerring\Debugger;

class WishlistForm extends Form
{
    public function __construct($controller, $wishlistItemID = null)
    {
        $fields = new FieldList();
        if (!is_null($wishlistItemID)) {
            
        }

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
                    $order->RecursiveFrequency = 30;
                    $order->PaidToClass = 'Member';
                    $order->PaidToClassID = $member->ID;
                    $order->Pay('Paystation', true);
                    return;
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

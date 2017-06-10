<?php
use SaltedHerring\Debugger;
class VoucherExpirer extends BuildTask
{
	protected $title = 'Voucher Expirer';
	protected $description = 'End user trials';

	protected $enabled = true;

	public function run($request)
    {
        $members = Member::get()->where('FreeUntil IS NOT NULL');
        foreach ($members as $member)
        {
            $freeUntil = strtotime($member->FreeUntil);
            if ($freeUntil <= time()) {
                $member->removeFromGroupByCode('landlords');
                $member->removeFromGroupByCode('realtors');
                $member->removeFromGroupByCode('tradesmen');

                $orders = $member->AccountRelatedOrders();
                $roles = array(
                    'landlords' => false,
                    'realtors'  => false,
                    'tradesmen' => false
                );
                foreach ($orders as $order)
                {
                    if ($order->Landlords) {
                        if (!$roles['landlords']) {
                            $member->addToGroupByCode('landlords', 'Landlords');
                            $roles['landlords'] = true;
                        }
                    }

                    if ($order->Realtors) {
                        if (!$roles['realtors']) {
                            $member->addToGroupByCode('realtors', 'Realtors');
                            $roles['realtors'] = true;
                        }
                    }

                    if ($order->Tradesmen) {
                        if (!$roles['tradesmen']) {
                            $member->addToGroupByCode('tradesmen', 'Tradesmen');
                            $roles['tradesmen'] = true;
                        }
                    }
                }
            }
        }
    }


}

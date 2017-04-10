<?php
use SaltedHerring\Debugger;

class  GatewayController extends Page_Controller
{

    public function index($request)
    {
        $status = $request->param('status');
        if ($orderID = $request->getVar('order_id')) {
            $order = Order::get()->byID($orderID);
            $classname = $order->PaidToClass;
            $goods = Versioned::get_by_stage($classname, 'Stage')->byID($order->PaidToClassID);
            $payment = PaystationPayment::get()->filter(array('MerchantReference' => $order->MerchantReference))->first();

            if ($status == 'success') {
                $this->Title = 'Payment successful.';
                $data = array(
                    'Message'   =>  "<p>You have paid \$$order->Amount->Amount.</p>",
                    'Content'   =>  $this->getContent($classname, $goods)
                );
            } else {
                $this->Title = 'Your payment didn\'t succeed.';
                $url = '#';
                if ($classname == 'PropertyPage') {
                    $url = '/member/action/list-property-for-' . $goods->RentOrSale . '?property_id=' . $goods->ID;
                } elseif ($classname == 'Member') {
                    $url = '/member/action/upgrade';
                } else {
                    $url = '/member/action/my-business';
                }
                $data = array(
                    'Message'   =>  "<p>$payment->ExceptionError</p>",
                    'Content'   =>  "<p><a href=\"$url\">Please try again »</a></p>",
                );
            }
        }

        return $this->customise($data)->renderWith(array('Page'));
    }

    private function getContent($classname, $goods)
    {
        if ($classname == 'PropertyPage') {
            return "<p>Your property will be listed until the end of <strong>$goods->ListingCloseOn</strong>.</p><p><a href=\"" . $goods->Link() . "\">View property »</a></p>";
        }

        if ($classname == 'Member') {
            return "<p>Your account has been upgraded.</p><p><a href=\"/member\">Member dashboard »</a></p>";
        }

        if ($classname == 'Business') {
            return "<p>Your business has been listed for <strong>$goods->ListLength</strong>.</p><p><a href=\"" . $goods->Link() . "\">View business »</a></p>";
        }

        return null;
    }

    public function getTitle()
    {

    }

    public function Title()
    {
        return 'Payment';
    }
}

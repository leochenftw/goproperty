<?php

class PreliveController extends Page_Controller
{
    public function index()
    {
        $request    =   $this->request;

        if ($price = $request->getVar('price')) {

            $order = SaltedOrder::prepare_order();
            $order->Landlords = false;
            $order->Realtors = false;
            $order->Tradesmens = false;

            $order->Amount->Amount  =   $price;
            // $order->RecursiveFrequency = 30;
            $order->PaidToClass     =   'Member';
            $order->PaidToClassID   =   Member::currentUserID();
            return $order->Pay('Paystation');
        }

        return $this->httpError(400, 'how about "?price=123"');
    }
}

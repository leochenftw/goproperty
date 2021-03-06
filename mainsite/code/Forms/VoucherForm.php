<?php
use SaltedHerring\Debugger;

class VoucherForm extends Form
{
    public function __construct($controller)
    {
        $fields = new FieldList();
        $fields->push(TextField::create('Serials', 'Voucher'));

        $actions = new FieldList();
        $actions->push(FormAction::create('doRedeem', 'Redeem')->addExtraClass('blue-button'));

        $required = array('Serials');

        $required_fields = new RequiredFields($required);

        parent::__construct($controller, 'VoucherForm', $fields, $actions, $required_fields);
        $this->setFormMethod('POST', true)
             ->setFormAction($controller->Link() . '/VoucherForm')->addExtraClass('contact-form');
    }

    public function doRedeem($data, $form)
    {
        Session::clear('Message');
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if (!empty($data['Serials'])) {
                $serials = $data['Serials'];
                if ($voucher = Voucher::get()->filter(array('Serials' => $serials))->first()) {
                    if (empty($voucher->MemberID)) {
                        $expiry = strtotime($voucher->ExpiryDate);
                        if ($expiry > time()) {
                            $member = Member::currentUser();
                            if (!empty($voucher->Email)) {

                                if ($voucher->Email == $member->Email) {

                                    $voucher->MemberID = $member->ID;
                                    $voucher->write();

                                    $member->FreeUntil = date('Y-m-d',strtotime(date("Y-m-d", time()) . " + 28 days"));
                                    $member->write();

                                    return $this->controller->redirectBack();
                                }
                            } else {
                                $voucher->MemberID = $member->ID;
                                $voucher->write();

                                $member->FreeUntil = date('Y-m-d',strtotime(date("Y-m-d", time()) . " + 28 days"));
                                $member->write();

                                return $this->controller->redirectBack();
                            }

                            $this->sessionMessage('You can\'t redeem this voucher. It is not for you.', 'is-danger');
                        }

                        $this->sessionMessage('Voucher has expired', 'is-danger');
                    }
                    $this->sessionMessage('Voucher has already been redeemed', 'is-danger');
                }
            }

            $this->sessionMessage('Invalid voucher', 'is-danger');
            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400, 'Session ID not matching');
    }


}

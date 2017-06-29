<?php

use SaltedHerring\Debugger;

class PromoSignupForm extends Form
{
    public function __construct($controller)
    {
        $fields = new FieldList();
        $fields->push(TextField::create('Name', 'Your Name'));
        $fields->push(EmailField::create('Email', 'Email'));
        $fields->push(
            OptionsetField::create(
                'AllowGroup',
                'Choose the account type that you apply for',
                array(
                    'landlords' =>  'Landlord',
                    'realtors'  =>  'Realtor',
                    'tradesmen' =>  'Tradesmen'
                ),
                'landlords'
            ));
        $actions = new FieldList();
        $actions->push(FormAction::create('doApply', 'Apply'));

        $required = new RequiredFields(array('Name', 'Email', 'AllowGroup'));

        parent::__construct($controller, 'PromoSignupForm', $fields, $actions, $required);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'signup', 'PromoSignupForm'))->addExtraClass('promo-signup-form');
    }

    public function doApply($data, $form)
    {
        Session::clear('Message');
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {

            if (!SaltedHerring\Utilities::valid_email($data['Email'])) {
                $form->addErrorMessage('Email', '"' . $data['Email'] . '"Not a valid email address', "is-danger");
                return Controller::curr()->redirectBack();
            }

            $member_exists = Member::get()->filter(array('Email' => $data['Email']));
            if (empty($member_exists->count())) {

                $member = new Member();
                $form->saveInto($member);

                $name = $data['Name'];
                $names = explode(' ', $name);
                $firstname = $names[0];
                $lastname = '';
                if (count($names) > 1) {
                    $lastname = $names[count($names) - 1];
                }

                $member->FirstName = $firstname;
                $member->Surname = $lastname;
                $member->ChangePassOnNextLogin = true;
                $member->write();

                $voucher = new Voucher();
                $form->saveInto($voucher);
                // $voucher->MemberID = $member->ID;
                $voucher->write();

                // $member->FreeUntil = date('Y-m-d',strtotime(date("Y-m-d", time()) . " + 28 days"));
                // $member->write();

                $email = new ConfirmationEmail($member);
                $email->send();
                $this->sessionMessage('Thank you for signing up! We have sent you an activation email to you. Please follow the instruction and activate your account.', 'good');
            } else {
                $form->addErrorMessage('Email', '"' . $data['Email'] . '" already exists. <a href="/Security/lostpassword">Really?</a>', "is-danger", false);
            }

            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400, 'not matching');
    }
}

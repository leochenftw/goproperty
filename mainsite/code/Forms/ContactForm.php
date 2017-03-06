<?php
use SaltedHerring\Debugger;

class ContactForm extends Form
{
    public function __construct($controller, $memberID, $businessID = null)
    {
        $fields = new FieldList();
        $fields->push(TextareaField::create(
            'Content',
            'Express your interest'
        ));

        if (!empty($memberID)) {
            $fields->push(HiddenField::create(
                'MemberID',
                'MemberID',
                $memberID
            ));
        }

        if (!empty($businessID)) {
            $fields->push(HiddenField::create(
                'businessID',
                'businessID',
                $businessID
            ));
        }

        $actions = new FieldList();
        $actions->push(FormAction::create('doContact', 'Contact')->addExtraClass('blue-button'));

        parent::__construct($controller, 'ContactForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction($controller->Link() . 'ContactForm')->addExtraClass('contact-form hide');
    }

    public function doContact($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            $email = new Email();
            $email->To = Member::get()->byID($data['MemberID'])->Email;
            $email->From = Member::currentUser()->Email;
            $email->Subject = 'Enquiry via goProperty';
            $email->Body = str_replace("\n", '<br /><br />', strip_tags($data['Content']));
            $email->send();

            $this->sessionMessage('Message sent', 'good');

            if (!empty($data['businessID'])) {
                $business = Business::get()->byID($data['businessID']);
                return $this->controller->redirect($business->Link());
            }

            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400, 'not matching');
    }


}

<?php
use SaltedHerring\Debugger;

class ContactForm extends Form
{
    protected $contacted = false;
    public function __construct($controller, $memberID = null, $businessID = null)
    {
        $fields = new FieldList();
        $fields->push(TextareaField::create(
            'Content',
            ''
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
             ->setFormAction($controller->Link() . 'ContactForm')->addExtraClass('contact-form');
    }

    public function doContact($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            $type = $this->controller->ClassName;
            $content = trim($data['Content']);
            $targetID = $type == 'PropertyPage' ? $this->controller->ID : $data['MemberID'];

            $property = null;
            $lister = null;

            if ($type == 'PropertyPage') {
                $property = PropertyPage::get()->byID($targetID);
                $lister = $property->Lister();
            } else {
                $lister = Member::get()->byID($targetID);
            }

            $target = $type == 'PropertyPage' ? $property : $lister->Business();
            // $interest = $target->Interests()->filter(array('Expired:not' => true, 'MemberID' => Member::currentUserID()))->first();
            if (empty($interest)) {
                $interest = new Interest();
                $email_type = 'business';
                if ($type == 'PropertyPage') {
                    $interest->PropertyID = $targetID;
                    $email_type = 'properties';
                } else {
                    $interest->BusinessID = $target->ID;
                }

                $interest->MemberID = Member::currentUserID();
                $interest->Message = $content;
                $interest->write();

                $email = new InterestNotification($lister, $email_type);
                $email->send();

                $copy = new ForYourCopyNotification(Member::currentUser(), $target->Title, $target->Link(), $content);
                $copy->send();

                if ($this->controller->request->isAjax()) {
                    return  json_encode(array(
                                'codde'     =>  200,
                                'message'   =>  'You contact message has been sent to the lister.'
                            ));
                }

                $this->sessionMessage('You contact message has been sent to the lister.', 'good');
                return $this->controller->redirectBack();
            }

            if ($this->controller->request->isAjax()) {
                return  json_encode(array(
                            'codde'     =>  200,
                            'message'   =>  'You have previously contacted this lister.'
                        ));
            }

            $this->sessionMessage('You have previously contacted this lister.', 'bad');
            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400, 'not matching');
    }


}

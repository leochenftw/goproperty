<?php
use SaltedHerring\Debugger;

class ContactForm extends Form
{
    protected $contacted = false;
    public function __construct($controller, $memberID, $businessID = null)
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
            if ($type == 'PropertyPage') {
                $targetID = $this->controller->ID;
                $target = PropertyPage::get()->byID($targetID);
                $interest = $target->Interests()->filter(array('MemberID' => Member::currentUserID()))->first();
                if (empty($interest)) {
                    $interest = new Interest();
                    $interest->PropertyID = $targetID;
                    $interest->MemberID = Member::currentUserID();
                    $interest->Message = $content;
                    $interest->write();
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

            $email = new Email();
            $email->To = Member::get()->byID($data['MemberID'])->Email;
            $email->From = Member::currentUser()->Email;
            $email->Subject = 'Enquiry via GoProperty';
            if (!empty($content)) {
                $content = str_replace("\n", '<br /><br />', $content);
            } else {
                $content = 'Someone is interested in the property that you are renting.';
            }

            $content .= '<br /><br />You may want to <a href="' . Director::absoluteBaseURL() . 'member/action/my-properties">jump on your dashboard</a> and check out the property list.';

            $email->Body = $content;
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

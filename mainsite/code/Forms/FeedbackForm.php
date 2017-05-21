<?php

use SaltedHerring\Debugger;
use Cocur\Slugify\Slugify;

class FeedbackForm extends Form
{
    public function __construct($controller, $ID, $rate_what)
    {
        $fields = new FieldList();
        $fields->push(
            DropdownField::create(
                'Stars',
                'Rate the ' . $rate_what,
                array(
                    '1' => '1. Bad Service – I would warn people against using these people',
                    '2' => '2. Not a great experience – The services was bad but there was extenuating circumstances',
                    '3' => '3. OK – The service was adequate for the cost',
                    '4' => '4. Good – The service was above average',
                    '5' => '5. Extremely good – This service was exemplarily'
                )
            )->setEmptyString('CLICK DROP DOWN TO RATE ' . $rate_what)
        );

        $fields->push(HiddenField::create('RatingID', 'RatingID', $ID));
        $fields->push(TextareaField::create('Comment', 'Comment'));

        $actions = new FieldList();
        $actions->push(FormAction::create('doFeedback', 'Submit'));

        $key = $controller->request->getVar('key');

        $required_fields = array(
            'Stars'
        );

        $required = new RequiredFields($required_fields);

        parent::__construct($controller, 'FeedbackForm', $fields, $actions, $required);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'feedback', $ID, 'FeedbackForm', "?key=$key"))
             ->addExtraClass('feedback-form column is-half is-offset-one-quarter');

    }

    public function doFeedback($data, $form)
    {
        if (!empty($data['SecurityID']) && !empty($data['RatingID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            $rating = Rating::get()->byID($data['RatingID']);
            $form->saveInto($rating);
            $rating->Key = null;
            $rating->write();
            $form->sessionMessage('Thanks for your feedback!', 'is-success');
            Session::clear("FormData.{$form->getName()}.data");
            return $this->controller->redirectBack();
        }

        return $this->controller->httpError(400);
    }
}

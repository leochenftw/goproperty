<?php
use SaltedHerring\Debugger;
use SaltedHerring\Utilities;

class MemberProfileForm extends Form {

    public function __construct($controller) {
        $member = Member::currentUser();
        $fields = new FieldList();
        // $fields->push(LiteralField::create('Cropped', !empty($this->getCroppedPortrait()) ? $this->getCroppedPortrait()->FillMax(300, 300) : null));
        $fields->push($uploader = UploadField::create('Image', 'Portrait'));
        $fields->push($email = EmailField::create('Email', 'Email')->setValue($member->Email)->setDescription('<a data-title="My profile | Change email address" href="/member/action/email-update" class="ajax-routed">Change email address</a>')->performReadonlyTransformation());
        $fields->push($first = TextField::create('FirstName', 'First name')->setValue($member->FirstName));
        $fields->push($last = TextField::create('Surname', 'Surname')->setValue($member->Surname));
        $fields->push($nickname = TextField::create('Nickname', 'Avatar/Nickname')->setValue($member->Nickname)->setDescription('Spaces and symbols will be omitted when save'));
        $fields->push(OptionsetField::create('NameToUse', 'Which name to display', array('Real name' => 'Real name', 'Nickname' => 'Nickname'), $member->NameToUse));
        $fields->push($addr = TextField::create('FullAddress', 'Address')->setValue($member->FullAddress));
        $fields->push($first = TextField::create('ContactNumber', 'Landline')->setValue($member->ContactNumber));
        $fields->push($first = TextField::create('MobileNumber', 'Mobile')->setValue($member->MobileNumber));
        $fields->push($showPhone = CheckboxField::create('DisplayPhonenumber', 'Show phone number on listing pages')->setValue($member->DisplayPhonenumber));

        $fields->push(HiddenField::create('StreetNumber','StreetNumber', $member->StreetNumber));
        $fields->push(HiddenField::create('StreetName','StreetName', $member->StreetName));
        $fields->push(HiddenField::create('Suburb','Suburb', $member->Suburb));
        $fields->push(HiddenField::create('City','City', $member->City));
        $fields->push(HiddenField::create('Region','Region', $member->Region));
        $fields->push(HiddenField::create('Country','Country', $member->Country));
        $fields->push(HiddenField::create('PostCode','PostCode', $member->PostCode));
        $fields->push(HiddenField::create('Lat','Lat', $member->Lat));
        $fields->push(HiddenField::create('Lng','Lng', $member->Lng));

        $fields->push(HiddenField::create('ContainerX','ContainerX', $this->getCoordinate('ContainerX')));
        $fields->push(HiddenField::create('ContainerY','ContainerY', $this->getCoordinate('ContainerY')));
        $fields->push(HiddenField::create('ContainerWidth','ContainerWidth', $this->getCoordinate('ContainerWidth')));
        $fields->push(HiddenField::create('ContainerHeight','ContainerHeight', $this->getCoordinate('ContainerHeight')));

        $fields->push(HiddenField::create('CropperX','CropperX', $this->getCoordinate('CropperX')));
        $fields->push(HiddenField::create('CropperY','CropperY', $this->getCoordinate('CropperY')));
        $fields->push(HiddenField::create('CropperWidth','CropperWidth', $this->getCoordinate('CropperWidth')));
        $fields->push(HiddenField::create('CropperHeight','CropperHeight', $this->getCoordinate('CropperHeight')));

        $uploader->setFolderName('members/' . Member::CurrentUserID() . '/portraits')
                ->setCanAttachExisting(false)
                ->setAllowedMaxFileNumber(1)
                ->setAllowedExtensions(array('jpg', 'jpeg', 'png'))
                ->setPreviewMaxWidth(400)
                ->setPreviewMaxHeight(400)
                ->setCanPreviewFolder(false)
                ->setAutoUpload(false)
                ->setFieldHolderTemplate('FrontendUploadField');

        $actions = new FieldList(
            $btnSubmit = FormAction::create('doUpdate','Save changes')
        );

        parent::__construct($controller, 'MemberProfileForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', "MemberProfileForm"));
    }

    private function getCoordinate($attribute)
    {
        if ($member = Member::currentUser()) {
            if ($member->Portrait()->exists()) {
                return $member->Portrait()->$attribute;
            }
        }

        return 0;
    }

    public function validate()
    {
        $result = parent::validate();

        $data = $this->getData();

        if ($nickname = $data['Nickname']) {
            $nickname = Utilities::sanitise($nickname, '', '');
            $test = Member::get()->filter(array('Nickname' => $nickname));
            if ($test->count() > 0 && empty($test->byID(Member::currentUserID()))) {
                $this->addErrorMessage('Nickname', '<strong><em>' . $data['Nickname'] . '</em></strong> has been taken. Please choose a different one. ', "bad", false);
                return false;
            }
        }

        return $result;
    }

    public function doUpdate($data, $form) {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {

            if ($member = Member::currentUser()) {

                $portrait = $member->Portrait()->exists() ? $member->Portrait() : new Portrait();
                if (!empty($data['Image']['type']['Uploads'][0])) {
                    $form->saveInto($portrait);
                } else {
                    $portrait->ContainerX = (int) $data['ContainerX'];
                    $portrait->ContainerY = (int) $data['ContainerY'];
                    $portrait->ContainerWidth = (int) $data['ContainerWidth'];
                    $portrait->ContainerHeight = (int) $data['ContainerHeight'];
                    $portrait->CropperX = (int) $data['CropperX'];
                    $portrait->CropperY = (int) $data['CropperY'];
                    $portrait->CropperWidth = (int) $data['CropperWidth'];
                    $portrait->CropperHeight = (int) $data['CropperHeight'];
                }
                $portrait->write();

                $form->saveInto($member);
                $member->write();
            }

            return Controller::curr()->redirectBack();
        }

        return Controller::curr()->httpError(400);
    }

    public function getCroppedPortrait()
    {
        if (!Member::CurrentUser()->Portrait()->exists()) {
            return null;
        }

        return Member::CurrentUser()->Portrait()->Image()->exists() ? Member::CurrentUser()->Portrait()->Image()->Cropped() : null;
    }

    public function getPortrait()
    {
        if (!Member::CurrentUser()->Portrait()->exists()) {
            return null;
        }

        return Member::CurrentUser()->Portrait()->Image()->exists() ? Member::CurrentUser()->Portrait()->Image() : null;
    }
}

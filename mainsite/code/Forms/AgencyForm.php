<?php

use SaltedHerring\Debugger;

class AgencyForm extends Form
{
    public function __construct($controller)
    {
        $agency = null;
        $fields = new FieldList();
        if ($agency_id = $controller->request->getVar('agency_id')) {
            $agency = Agency::get()->byID($agency_id);
        }

        $title = !empty($agency) ? $agency->Title : $controller->request->getVar('agency_title');

        $fields->push(TextField::create(
            'Title',
            'Name of agency',
            $title
        ));

        $fields->push(TextField::create(
            'ContactNumber',
            'Contact number',
            !empty($agency) ? $agency->ContactNumber : null
        ));

        $fields->push(TextareaField::create(
            'Blurb',
            'Blurb',
            !empty($agency) ? $agency->Blurb : null
        ));

        $fields->push($logo = UploadField::create('Logo', 'Logo'));

        $logo->setFolderName('agencylogos')
                ->setCanAttachExisting(false)
                ->setAllowedExtensions(array('jpg', 'jpeg', 'png'))
                ->setPreviewMaxWidth(400)
                ->setPreviewMaxHeight(400)
                ->setCanPreviewFolder(false)
                ->setAutoUpload(false)
                ->setFieldHolderTemplate('LogoUploadField');


        if (!empty($agency)) {
            $fields->push(HiddenField::create('AgencyID', 'AgencyID', $agency->ID));
            if ($agency->Logo()->exists()) {
                $logo = $agency->Logo();
                $ContainerX = $logo->ContainerX;
                $ContainerY = $logo->ContainerY;
                $ContainerWidth = $logo->ContainerWidth;
                $ContainerHeight = $logo->ContainerHeight;

                $CropperX = $logo->CropperX;
                $CropperY = $logo->CropperY;
                $CropperWidth = $logo->CropperWidth;
                $CropperHeight = $logo->CropperHeight;
            }
        }

        $fields->push(HiddenField::create('ContainerX','ContainerX', !empty($ContainerX) ? $ContainerX : 0));
        $fields->push(HiddenField::create('ContainerY','ContainerY', !empty($ContainerY) ? $ContainerY : 0));
        $fields->push(HiddenField::create('ContainerWidth','ContainerWidth', !empty($ContainerWidth) ? $ContainerWidth : 0));
        $fields->push(HiddenField::create('ContainerHeight','ContainerHeight', !empty($ContainerHeight) ? $ContainerHeight : 0));

        $fields->push(HiddenField::create('CropperX','CropperX', !empty($CropperX) ? $CropperX : 0));
        $fields->push(HiddenField::create('CropperY','CropperY', !empty($CropperY) ? $CropperY : 0));
        $fields->push(HiddenField::create('CropperWidth','CropperWidth', !empty($CropperWidth) ? $CropperWidth : 0));
        $fields->push(HiddenField::create('CropperHeight','CropperHeight', !empty($CropperHeight) ? $CropperHeight : 0));

        $actions = new FieldList();
        $actions->push(FormAction::create('doSubmit', 'Submit'));

        $required_fields = array(
            'Title'
        );

        $required = new RequiredFields($required_fields);

        parent::__construct($controller, 'AgencyForm', $fields, $actions, $required);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', 'AgencyForm'))->addExtraClass('agency-form');
    }

    public function doSubmit($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            // Debugger::inspect($data);
            $agency = !empty($data['AgencyID']) ? Agency::get()->byID($data['AgencyID']) : new Agency();
            $logo = $agency->Logo();
            $form->saveInto($agency);

            if (!empty($logo) && empty($data['Logo']['type']['Uploads'][0])) {
                $agency->LogoID = $logo->ID;
            }

            $agency->write();

            $logo = $agency->Logo();

            if (!empty($logo)) {
                $logo->ContainerX = (int) $data['ContainerX'];
                $logo->ContainerY = (int) $data['ContainerY'];
                $logo->ContainerWidth = (int) $data['ContainerWidth'];
                $logo->ContainerHeight = (int) $data['ContainerHeight'];
                $logo->CropperX = (int) $data['CropperX'];
                $logo->CropperY = (int) $data['CropperY'];
                $logo->CropperWidth = (int) $data['CropperWidth'];
                $logo->CropperHeight = (int) $data['CropperHeight'];
            }
            $logo->write();

            if ($this->controller->request->isAjax()) {
                return  json_encode(array(
                            'title'     =>  $agency->Title,
                            'thumbnail' =>  !empty($agency->LogoID) ? $agency->Logo()->FillMax(100, 100)->URL : 'https://placehold.it/100x100',
                            'then'      =>  'close_form'
                        ));
            }

            return $this->controller->redirect('/member/action/agencies');
        }

        return Controller::curr()->httpError(400);
    }

    public function getLogo()
    {
        if ($id = $this->controller->request->getVar('agency_id')) {
            $agency = Agency::get()->byID($id);
            return $agency->Logo();
        }
        return null;
    }
}

<?php
use SaltedHerring\Debugger;

class BusinessForm extends Form
{
    public function __construct($controller, $business = null)
    {
        $fields = new FieldList();
        $fields->push($uploader = UploadField::create(
            'Logo',
            'Your business logo'
        ));

        $uploader->setFolderName('business')
                ->setCanAttachExisting(false)
                ->setAllowedMaxFileNumber(1)
                ->setAllowedExtensions(array('jpg', 'jpeg', 'png'))
                ->setPreviewMaxWidth(580)
                ->setPreviewMaxHeight(338)
                ->setCanPreviewFolder(false)
                ->setAutoUpload(false)
                ->setFieldHolderTemplate('LogoUploadField');
        $uploader->CropperWidth = 580;
        $uploader->CropperHeight = 338;

        $fields->push(TextField::create(
            'Title',
            'Your business name',
            !empty($business) ? $business->Title : null
        ));

        $fields->push($addr = TextField::create('FullAddress', 'Address', !empty($business) ? $business->FullAddress : null));
        $fields->push($first = TextField::create('ContactNumber', 'Landline/Mobile', !empty($business) ? $business->ContactNumber : null));

        $fields->push(TextField::create(
                            'ServicesInput',
                            'Services'
                        )
                        ->setAttribute('placeholder', 'e.g. Plumber')
                        ->setAttribute('data-endpoint', '/api/v1/service/')
                        ->setDescription('type and add services that your businss offers')
                    );
        // $fields->push(HiddenField::create('Services[]','Services[]'));
        $strServices = '';
        if (!empty($business) && $business->Services()->exists()) {
            $services = $business->Services();
            foreach ($services as $service)
            {
                $strServices .= '<button data-service-id="' . $service->ID . '">' . $service->Title . '</button>' . "\n";
                $strServices .= '<input type="hidden" name="Services[]" value="' . $service->ID . '" />' . "\n";
            }
        }

        $fields->push(LiteralField::create('ServicesHolder', '<div id="tagged-services">' . $strServices . '</div>'));

        $fields->push(TextareaField::create(
            'Content',
            'Introduction',
            !empty($business) ? $business->Content : null
        ));

        $fields->push(HiddenField::create('StreetNumber','StreetNumber', !empty($business) ? $business->StreetNumber : null));
        $fields->push(HiddenField::create('StreetName','StreetName', !empty($business) ? $business->StreetName : null));
        $fields->push(HiddenField::create('Suburb','Suburb', !empty($business) ? $business->Suburb : null));
        $fields->push(HiddenField::create('City','City', !empty($business) ? $business->City : null));
        $fields->push(HiddenField::create('Region','Region', !empty($business) ? $business->Region : null));
        $fields->push(HiddenField::create('Country','Country', !empty($business) ? $business->Country : null));
        $fields->push(HiddenField::create('PostCode','PostCode', !empty($business) ? $business->PostCode : null));
        $fields->push(HiddenField::create('Lat','Lat', !empty($business) ? $business->Lat : null));
        $fields->push(HiddenField::create('Lng','Lng', !empty($business) ? $business->Lng : null));
        $fields->push(HiddenField::create('BusinessID','BusinessID', !empty($business) ? $business->ID : null));

        $actions = new FieldList();
        $actions->push(FormAction::create('saveBusiness', !empty($business) ? 'Update' : 'Create'));

        parent::__construct($controller, 'BusinessForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', 'BusinessForm'))->addExtraClass('business-form');
    }

    public function saveBusiness($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if ($id = $data['BusinessID']) {
                $business = Business::get()->byID($id);
            } else {
                $business = new Business();
            }
            if (empty($data['Logo']['type']['Uploads'][0])) {
                if ($business->Logo()->exists()) {
                    $LogoID = $business->LogoID;
                }
            }
            $form->saveInto($business);
            if (!empty($LogoID)) {
                $business->LogoID = $LogoID;
            }
            $business->write();

            $owner = $business->BusinessOwner();
            $owner->BusinessID = $business->ID;
            $owner->write();

            if ($services = $data['Services']) {
                foreach ($services as $serviceID) {
                    $business->Services()->add($serviceID);
                }
            }

            return $this->controller->redirectBack();
        }

        return Controller::curr()->httpError(400, 'not matching');
    }

    public function getLogo()
    {
        if (!Member::CurrentUser()->Business()->exists()) {
            return null;
        }

        if (!Member::CurrentUser()->Business()->Logo()->exists()) {
            return null;
        }

        return Member::CurrentUser()->Business()->Logo();
    }

}

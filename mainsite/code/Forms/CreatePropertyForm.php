<?php
use SaltedHerring\Debugger;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;

class CreatePropertyForm extends Form
{
    protected $FormTitle = '';
    protected $FormSubtitle = '';
    protected $steps = 5;
    protected $step = 0;
    protected $property = null;

    public function __construct($controller)
    {
        Session::clear('FormInfo');

        $propertyID     =   $controller->request->getVar('id');
        if (!empty($propertyID)) {
            Session::set('WorkingPropertyID', $propertyID);
        } elseif ($controller->request->isGet()) {
            Session::clear('WorkingPropertyID');
        }

        $this->step     =   $controller->request->getVar('step');

        if (empty($this->step) && $controller->request->isPost()) {
            $this->step =   Session::get('PropertyStep');
        }

        $modifying      =   $controller->request->getVar('editing');
        // Debugger::inspect($this->step);
        $this->step     =   !empty($this->step) ? $this->step : 0;

        if (empty($propertyID) && $controller->request->isPost()) {
            $propertyID =   Session::get('WorkingPropertyID');
        }

        Session::set('PropertyStep', $this->step);

        // Debugger::inspect($propertyID);
        // Debugger::inspect($this->step);
        // Debugger::inspect(Session::get_all());

        $this->property =   !empty($propertyID) ? Property::get()->byID($propertyID) : null;
        $property       =   $this->property;

        // if (!empty($propertyID) && empty($property)) {
        //     Session::clear('WorkingPropertyID');
        // }

        $fields = new FieldList();

        switch ($this->step) {
            case 0:
                // Debugger::inspect(!empty($property) ? $property->FullAddress : null);
                $this->FormTitle = 'Where is your property?';
                $this->FormSubtitle = 'This will help us quickly locate your property';

                $fields->push(TextField::create('FullAddress', 'Street address', !empty($property) ? $property->FullAddress : null)->addExtraClass('google-placed'));
                $fields->push(TextField::create('StreetNumber', 'Street number', !empty($property) ? $property->StreetNumber : null));
                $fields->push(TextField::create('StreetName', 'Street name', !empty($property) ? $property->StreetName : null));
                $fields->push(
                    DropdownField::create(
                        'Region',
                        'Region',
                        Config::inst()->get('NewZealand', 'Regions'),
                        !empty($property) ? $property->Region : null
                    )->setEmptyString('- select one -')
                     ->setAttribute('data-direct-child', 'CreatePropertyForm_CreatePropertyForm_City')
                );

                $fields->push(
                    DropdownField::create(
                        'City',
                        'City'
                    )->setEmptyString('- select one -')
                     ->setAttribute('data-direct-child', 'CreatePropertyForm_CreatePropertyForm_Suburb')
                     ->setAttribute('data-option', !empty($property) ? $property->City : null)
                );

                $fields->push(
                    DropdownField::create(
                        'Suburb',
                        'Suburb'
                    )->setEmptyString('- select one -')
                     ->setAttribute('data-option', !empty($property) ? $property->Suburb : null)
                );

                $fields->push(TextField::create('Country','Country', !empty($property) ? $property->Country : null));
                $fields->push(TextField::create('PostCode','PostCode', !empty($property) ? $property->PostCode : null));

                $fields->push(HiddenField::create('Lat','Lat', !empty($property) ? $property->Lat : null));
                $fields->push(HiddenField::create('Lng','Lng', !empty($property) ? $property->Lng : null));
                break;
            case 1:
                $this->FormTitle = 'What your property is like?';
                $this->FormSubtitle = 'This will help on the search result.';

                $fields->push(
                    DropdownField::create(
                        'PropertyType',
                        'What\'s your property type?',
                        Config::inst()->get('Property', 'Basic'),
                        !empty($property) ? $property->PropertyType : null
                    )->setEmptyString('- select one -')
                );

                $fields->push(
                    TextField::create(
                        'UnitNumber',
                        'Does it have an unit/flat number?',
                        !empty($property) ? $property->UnitNumber : null
                    )->setAttribute('placeholder', 'e.g. Level 5 | Flat 6 | Unit 4')
                     ->setDescription('Leave empty if it doesn\'t')
                );

                break;
            case 2:
                $this->FormTitle = 'Can you describe your property a bit more?';
                $this->FormSubtitle = 'This will help on the search result.';

                $fields->push(DropdownField::create(
                    'NumBedrooms',
                    'How many bedrooms in your property?',
                    $this->makeList('MaxBedroom'),
                    !empty($property) ? $property->NumBedrooms : null
                )->setEmptyString('- select one -'));

                $fields->push(DropdownField::create(
                    'NumBathrooms',
                    'How many bathrooms in your property?',
                    $this->makeList('MaxBathroom'),
                    !empty($property) ? $property->NumBathrooms : null
                )->setEmptyString('- select one -'));

                $fields->push(DropdownField::create(
                    'MaxCapacity',
                    'Up to how many people can your property allow',
                    $this->makeList('MaxCapacity'),
                    !empty($property) ? $property->MaxCapacity : null
                )->setEmptyString('- I don\'t know -'));

                $fields->push(DropdownField::create(
                    'Parking',
                    'Parking option',
                    Config::inst()->get('Property', 'Parking'),
                    !empty($property) ? $property->Parking : null
                )->setEmptyString('- select one -'));

                $fields->push(CheckboxField::create(
                    'SmokeAlarm',
                    'Smoke alarm(s) installed',
                    !empty($property) ? $property->SmokeAlarm : 1
                ));

                $fields->push(CheckboxField::create(
                    'Insulation',
                    'Insulation included',
                    !empty($property) ? $property->Insulation : 1
                ));

                break;

            case 3:
                $this->FormTitle = 'How does your property look like?';
                $this->FormSubtitle = 'Time to upload some photos of your property.';

                $fields->push($gallery = UploadField::create('Gallery', 'Gallery'));

                $gallery->setFolderName('members/' . Member::CurrentUserID() . '/propertyimages')
                        ->setCanAttachExisting(false)
                        // ->setAllowedMaxFileNumber(10)
                        ->setAllowedExtensions(array('jpg', 'jpeg', 'png'))
                        ->setPreviewMaxWidth(400)
                        ->setPreviewMaxHeight(400)
                        ->setCanPreviewFolder(false)
                        ->setAutoUpload(false)
                        ->setFieldHolderTemplate('PropertyGalleryUploader')
                        ->addExtraClass('viewable-gallery');

                $gallery->customise(
                    array(
                        'Existings' => $property->Gallery()->sort('ID', 'ASC')
                    )
                );

                $fields->push(HiddenField::create('ExistingGallery', 'ExistingGallery', implode(',', $property->Gallery()->Column())));
                $fields->push(HiddenField::create('toDelete', 'toDelete'));
                break;

            case 4:
                $this->FormTitle = 'Do we miss anything?';
                $this->FormSubtitle = 'Anything eles you wish to add?';

                $fields->push($details = TextareaField::create('Content', 'Details')->setAttribute('placeholder', 'Provide details such as heating, flooring, whiteware etc. e.g. The property has features such as termsheet facebook focus product management customer partner network business-to-consumer.'));

                $fields->push($amenities = TextareaField::create('Amenities', 'Amenities')->setAttribute('placeholder', 'Amentities in the area such as ...'));

                $details->setValue(!empty($property) ? $property->Content : null);
                $amenities->setValue(!empty($property) ? $property->Amenities : null);

                break;

            case 5:
                $this->FormTitle = 'Overview';
                $this->FormSubtitle = 'Please approve your inputs.';
                break;
        }

        //


        // ACTIONS -------------------------------------------------------------------------------------------------------------------

        $next_label = $this->step < $this->steps ? 'Next' : 'Complete';

        if (!empty($modifying)) {
            $next_label = 'Save';
            $fields->push(HiddenField::create('Editing', 'Editing', 1));
        }

        $actions = new FieldList();
        if (!$controller->request->isAjax()) {
            $actions->push($prev = FormAction::create('doReverse', 'Prev')->addExtraClass('pagination-previous'));
            if ($this->step == 0 || !empty($modifying)) {
                $prev->disabled = true;
            }
        }

        $actions->push(FormAction::create('doSubmit', $next_label)->addExtraClass('pagination-next'));

        // $required_fields = array(
        //     // 'FullAddress',
        //     // 'ListingCloseOn'
        // );
        //
        // if ($this->step == 0) {
        //     $required_fields[] = 'FullAddress';
        // }

        // $required = new RequiredFields($required_fields);
        // parent::__construct($controller, 'CreatePropertyForm', $fields, $actions, $required);
        parent::__construct($controller, 'CreatePropertyForm', $fields, $actions);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', 'CreatePropertyForm'))->addExtraClass('property-form');
    }

    public function validate()
    {
        return true;
    }

    private function makeList($list_of)
    {
        $max = Config::inst()->get('Property', $list_of);
        $arr = array();
        for ($i = 1; $i <= $max; $i++)
        {
            $arr[(string) $i] = $i;
        }

        return $arr;
    }

    public function doReverse($data, $form)
    {
        $this->step     =   Session::get('PropertyStep');
        // Debugger::inspect($this->step);
        $this->step     =   !empty($this->step) ? $this->step : 0;
        $this->step--;

        $propertyID     =   Session::get('WorkingPropertyID');

        Session::set('PropertyStep', $this->step);

        return $this->controller->redirect('/member/action/manage-property?id=' . $propertyID . '&step=' . $this->step);
    }

    public function doSubmit($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            $this->step     =   Session::get('PropertyStep');
            if ($this->step == 0) {
                $result = true;
                $error_fields = array();
                if (empty($data['Region'])) {
                    $result = false;
                    $error_fields[] = 'Region';
                }

                if (empty($data['City'])) {
                    $result = false;
                    $error_fields[] = 'City';
                }

                if (empty($data['Suburb'])) {
                    $result = false;
                    $error_fields[] = 'Suburb';
                }

                if (!$result) {
                    if ($this->request->isAjax()) {
                        return  json_encode(array(
                                    'then'          =>  'show_errors',
                                    'error_fields'  =>  $error_fields
                                ));
                    }
                }
            }
            // Debugger::inspect($this->step);
            $propertyID     =   Session::get('WorkingPropertyID');
            if (empty($data['Editing'])) {
                $this->step     =   !empty($this->step) ? $this->step : 0;
                $this->step++;
            } else {
                $this->step = 5;
            }

            if (empty($propertyID)) {
                $property   =   new Property();
            } else {
                $property   =   Property::get()->byID($propertyID);
            }

            $form->saveInto($property);

            if (!empty($data['ExistingGallery'])) {
                $gallery = explode(',' , $data['ExistingGallery']);
                foreach ($gallery as $item) {
                    $property->Gallery()->add($item);
                }
            }

            if (!empty($data['toDelete'])) {
                $image_ids = explode(',' , $data['toDelete']);
                foreach ($image_ids as $image_id) {
                    $image = Image::get()->byID($image_ids);
                    $image->delete();
                }
            }

            $property->write();

            if (empty($propertyID)) {
                Session::set('WorkingPropertyID', $property->ID);
            }

            if ($this->step <= 5) {
                Session::set('PropertyStep', $this->step);
                return $this->controller->redirect('/member/action/manage-property?id=' . $property->ID . '&step=' . $this->step);
            }

            if ($this->controller->request->isAjax()) {
                return  json_encode(array(
                            'title'     =>  $property->Title,
                            'thumbnail' =>  $property->Gallery()->count() > 0 ? $property->Gallery()->first()->FillMax(100, 100)->URL : 'https://placehold.it/100x100',
                            'then'      =>  'close_form'
                        ));
            }

            return $this->controller->redirect('/member/action/properties');
        }

        return Controller::curr()->httpError(400);
    }

    public function getNav()
    {
        $nav = array();
        for ($i = 0; $i <= $this->steps; $i++)
        {
            $item = array(
                'URL'   =>  '/member/action/manage-property?id=' . $this->property->ID . '&step=' . $i . ($i < $this->steps ? '&editing=1' : ''),
                'HTML'  =>  $i + 1,
                'Title' =>  $this->titleMaker($i),
                'Step'  =>  $this->step + 1
            );
            $nav[] = new ArrayData($item);
        }

        return new ArrayList($nav);
    }

    private function titleMaker($step)
    {
        switch ($step) {
            case 0:
                $FormTitle = 'Where is your property?';
                break;
            case 1:
                $FormTitle = 'What your property is like?';
                break;
            case 2:
                $FormTitle = 'Can you describe your property a bit more?';
                break;
            case 3:
                $FormTitle = 'How does your property look like?';
                break;
            case 4:
                $FormTitle = 'Do we miss anything?';
                break;
            default:
                $FormTitle = 'Overview';
                break;
        }

        return $FormTitle;
    }
}

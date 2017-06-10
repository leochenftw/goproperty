<?php
use SaltedHerring\Debugger;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;

class PropertyForm extends Form
{
    protected $FormTitle = '';

    public function __construct($controller, $name, $prop = null)
    {
        if (!empty($prop) && !empty($prop->Title)) {
            $this->FormTitle = $prop->Title;
        }

        $fields = new FieldList();
        $fields->push(HiddenField::create(
            'RentOrSale',
            'RentOrSale',
            $name == 'RentForm' ? 'rent' : 'sale'
        ));

        $fields->push(DropdownField::create(
            'PropertyType',
            'Property type',
            Config::inst()->get('PropertyPage', $name),
            !empty($prop) ? $prop->PropertyType : null
        )->setEmptyString('- select one -'));

        $fields->push($unit = TextField::create(
            'UnitNumber',
            'Unit/Room/Apartment/Flat number',
            !empty($prop) ? $prop->UnitNumber : null
        )->setAttribute('placeholder', 'e.g. Level 5 | Flat 6 | Unit 4'));

        $fields->push($addr = TextField::create('FullAddress', 'Street address')->addExtraClass('google-placed'));

        if (!empty($prop)) {
            $addr->setValue($prop->FullAddress);
        }

        $fields->push(HiddenField::create('StreetNumber','StreetNumber', !empty($prop) ? $prop->StreetNumber : null));
        $fields->push(HiddenField::create('StreetName','StreetName', !empty($prop) ? $prop->StreetName : null));
        $fields->push(HiddenField::create('Suburb','Suburb', !empty($prop) ? $prop->Suburb : null));
        $fields->push(HiddenField::create('City','City', !empty($prop) ? $prop->City : null));
        $fields->push(HiddenField::create('Region','Region', !empty($prop) ? $prop->Region : null));
        $fields->push(HiddenField::create('Country','Country', !empty($prop) ? $prop->Country : null));
        $fields->push(HiddenField::create('PostCode','PostCode', !empty($prop) ? $prop->PostCode : null));
        $fields->push(HiddenField::create('Lat','Lat', !empty($prop) ? $prop->Lat : null));
        $fields->push(HiddenField::create('Lng','Lng', !empty($prop) ? $prop->Lng : null));

        $fields->push($agent = TextField::create(
            'AgencyReference',
            'Agency reference #',
            !empty($prop) ? $prop->AgencyReference : null
        )->addExtraClass('hide'));

        if (!empty($prop) && !empty($prop->ListerAgencyID)) {
            $agent->removeExtraClass('hide');
        }

        $fields->push(TextField::create('ContactNumber', 'Contact number', !empty($prop) ? $prop->ContactNumber : (!empty(Member::currentUser()->ContactNumber) ? Member::currentUser()->ContactNumber : null)));

        $fields->push($details = TextareaField::create('Content', 'Details')->setAttribute('placeholder', 'Provide details such as heating, flooring, whiteware etc. e.g. The property has features such as termsheet facebook focus product management customer partner network business-to-consumer.'));//->setDescription('Provide details such as heating, insulation, flooring, whiteware etc.'));

        $fields->push(DropdownField::create(
            'NumBedrooms',
            'Bedrooms',
            $this->makeList('MaxBedroom'),
            !empty($prop) ? $prop->NumBedrooms : null
        )->setEmptyString('- select one -'));

        $fields->push(DropdownField::create(
            'NumBathrooms',
            'Bathrooms',
            $this->makeList('MaxBathroom'),
            !empty($prop) ? $prop->NumBathrooms : null
        )->setEmptyString('- select one -'));

        $fields->push($amenities = TextareaField::create('Amenities', 'Amenities')->setAttribute('placeholder', 'Amentities in the area such as termsheet facebook focus product management partner network termsheet facebook focus product management.'));

        $fields->push(DropdownField::create(
            'Parking',
            'Parking option',
            Config::inst()->get('PropertyPage', 'Parking'),
            !empty($prop) ? $prop->Parking : null
        )->setEmptyString('- select one -'));



        $fields->push(CheckboxField::create(
            'SmokeAlarm',
            'Smoke alarm',
            !empty($prop) ? $prop->SmokeAlarm : 1
        ));

        $fields->push(CheckboxField::create(
            'Insulation',
            'Insulation',
            !empty($prop) ? $prop->Insulation : 1
        ));

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

        $member = Member::currentUser();
        if ($member->MemberOf()->exists()) {
            $fields->push(DropdownField::create(
                'ListerAgencyID',
                'List as',
                $member->MemberOf()->map('ID', 'Title'),
                !empty($prop) ? $prop->ListerAgencyID : null
            )->setEmptyString($name == 'RentForm' ? 'Myself' : 'Private Sale'));
        }

        if (!empty($prop)) {
            $addr->setValue($prop->FullAddress);
            $details->setValue(strip_tags(str_replace('</p>', "\n", $prop->Content)));

            $amenities->setValue($prop->Amenities);

            //$gallery->setItems($prop->Gallery());
            //Debugger::inspect($prop->Gallery()->Column());
            $gallery->customise(
                array(
                    'Existings' => $prop->Gallery()->sort('ID', 'ASC')
                )
            );

            $fields->push(HiddenField::create('ExistingGallery', 'ExistingGallery', implode(',', $prop->Gallery()->Column())));
            $fields->push(HiddenField::create('toDelete', 'toDelete'));
            $fields->push(HiddenField::create('PropertyID', 'PropertyID', $prop->ID));
        }

        $daily_charge = Config::inst()->get('PropertyPage', 'DailyCharge');
        $til_charge = $name == 'RentForm' ? Config::inst()->get('PropertyPage', 'TilRented') : Config::inst()->get('PropertyPage', 'TilSold');

        $listing_desc = 'Rate: $' . $daily_charge . ' per day. ';

        $listingOption = OptionsetField::create(
            'ListTilGone',
            'Listing options',
            array(
                'By length: $' . $daily_charge .' per day',
                'List until ' . ($name == 'RentForm' ? 'rented' : 'sold') . ': $' . $til_charge
            ),
            !empty($prop) ? $prop->ListTilGone : null
        );

        if ((!empty($prop) && $prop->hasPaid()) || ($member->inFreeTrial() && !empty($prop) && $prop->isPublished())) {
            $listingOption = $listingOption->performReadonlyTransformation();
        }

        $fields->push($listingOption);

        $list_until = DateField::create('ListingCloseOn','Listing ends', !empty($prop) ? $prop->ListingCloseOn : null);

        if (!empty($prop)) {
            if ($prop->isPublished()) {
                $list_until = $list_until->setDescription(null)->performReadonlyTransformation();
            }

            if ($prop->hasPaid()) {
                $this->ListFree = true;
                $this->ListTilGone = $prop->ListTilGone;
                $this->ListUntil = $prop->ListingCloseOn;
            } elseif (!empty($prop->ListingCloseOn)) {
                // Debugger::inspect();
                $today  =   date_create(date("Y-m-d"));
                $until  =   date_create($prop->ListingCloseOn);
                if ($until >= $today) {
                    $diff   =   date_diff($today,$until);
                    $prop->ListingDuration = $this->Duration = $diff->days + 1;
                    $this->AmountToPay = $daily_charge * $prop->ListingDuration;
                    $listing_desc .= 'You are going to list this property for <strong>' . $prop->ListingDuration . '</strong> day(s). This is going to cost you: <span>$' . $this->AmountToPay . '</span>';
                    $list_until->setDescription($listing_desc);
                }
            }
        }

        if (!empty($prop) && $prop->hasPaid()) {
            $list_until = $list_until->performReadonlyTransformation();
        }

        $fields->push($list_until);

        // ACTIONS -------------------------------------------------------------------------------------------------------------------
        $actions = new FieldList();

        $actions->push($btnWithdraw = FormAction::create('doWithdraw', 'Withdraw')->addExtraClass('red'));

        if (!empty($prop) && $prop->isPublished()) {

        } else {
            $actions->push(FormAction::create('doSubmit', !empty($prop) ? 'Save changes' : 'Create'));
        }

        $actions->push($btnList = FormAction::create('doList', 'List it')->addExtraClass('green'));

        if (!empty($prop)) {
            if ($prop->isPublished()) {
                $btnList->addExtraClass('hide');
            } else {
                $btnWithdraw->addExtraClass('hide');
            }
        } else {
            $btnList->addExtraClass('hide');
            $btnWithdraw->addExtraClass('hide');
        }

        $required_fields = array(
            'FullAddress',
            // 'ListingCloseOn'
        );

        $required = new RequiredFields($required_fields);
        parent::__construct($controller, $name, $fields, $actions, $required);
        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', $name))->addExtraClass('property-form');
    }

    protected function makeList($list_of)
    {
        $max = Config::inst()->get('PropertyPage', $list_of);
        $arr = array();
        for ($i = 1; $i <= $max; $i++)
        {
            $arr[(string) $i] = $i;
        }

        return $arr;
    }

    public function validate()
    {
        $result = parent::validate();
        $data = $this->getData();

        if (!empty($data['ListingCloseOn'])) {
            $today  =   date_create(date("Y-m-d"));
            $until  =   date_create($data['ListingCloseOn']);
            if ($until < $today) {
                $this->addErrorMessage('ListingCloseOn', 'Listing end date cannot be earlier than today!', 'bad');
                return false;
            }
        }
        return $result;
    }

    public function doList($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if (!empty($data['PropertyID'])) {
                $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($data['PropertyID']);
                // $property->ListingCloseOn = $data['ListingCloseOn'];
                // $property->writeToStage('Stage');
                $this->doSubmit($data, $form, true);

                if ($member = Member::currentUser()) {
                    if ($member->inFreeTrial()) {
                        $property->writeToStage('Live');
                        return Controller::curr()->redirect('/member/action/' . ($this->Name == 'RentForm' ? 'list-property-for-rent' : 'list-property-for-sale') . '?property_id=' . $property->ID);
                    }
                }

                if ($property->hasPaid()) {
                    $property->writeToStage('Live');
                    return Controller::curr()->redirect('/member/action/' . ($this->Name == 'RentForm' ? 'list-property-for-rent' : 'list-property-for-sale') . '?property_id=' . $property->ID);
                } else {
                    if ($property->ListTilGone) {
                        $amount = ($property->RentOrSale == 'rent') ? Config::inst()->get('PropertyPage', 'TilRented') : Config::inst()->get('PropertyPage', 'TilSold');
                    } else {
                        $daily_charge = Config::inst()->get('PropertyPage', 'DailyCharge');
                        $amount = $daily_charge * $property->ListingDuration;
                    }

                    $order = SaltedOrder::prepare_order();
                    $order->Amount->Amount = $amount;

                    $order->PaidToClass = 'PropertyPage';
                    $order->PaidToClassID = $property->ID;
                    $order->Pay('Paystation');
                    return;
                }
            }
        }

        return Controller::curr()->httpError(400, 'missing token');
    }

    public function doWithdraw($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            if (!empty($data['PropertyID'])) {
                $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($data['PropertyID']);
                $property->deleteFromStage('Live');
                return Controller::curr()->redirect('/member/action/' . ($this->Name == 'RentForm' ? 'list-property-for-rent' : 'list-property-for-sale') . '?property_id=' . $property->ID);
            }
        }

        return Controller::curr()->httpError(400);
    }

    public function doSubmit($data, $form, $noredirect = false)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {

            if (!empty($data['PropertyID'])) {
                $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($data['PropertyID']);
            } else {
                $property = new PropertyPage();
            }

            $ListUntil = $property->ListingCloseOn;
            $ListTilGone = $property->ListTilGone;

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

            if (empty($property->ListerID)) {
                $property->ListerID = Member::currentUserID();
            }

            if ($property->hasPaid()) {
                $property->ListingCloseOn = $ListUntil;
                $property->ListTilGone = $ListTilGone;
            }


            $property->writeToStage('Stage');
            $this->sessionMessage('Property saved. Do you want to <a href="/member/action/list-property-for-rent">create another one</a>?', 'good', false);
            //return Controller::curr()->redirectBack();
            if ($noredirect === true) {
                return true;
            }

            return Controller::curr()->redirect('/member/action/' . ($this->Name == 'RentForm' ? 'list-property-for-rent' : 'list-property-for-sale') . '?property_id=' . $property->ID);
        }

        return Controller::curr()->httpError(400);
    }



}

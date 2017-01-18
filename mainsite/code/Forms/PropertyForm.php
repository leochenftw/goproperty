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

		$fields->push($addr = TextField::create('FullAddress', 'Address')->addExtraClass('google-placed'));

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

        $fields->push($details = TextareaField::create('Content', 'Details')->setAttribute('placeholder', 'The property has features such as termsheet facebook focus product management customer partner network business-to-consumer.')->setDescription('Provide details such as heating, <br />insulation, flooring, <br />whiteware etc.'));

        $fields->push(DropdownField::create(
            'NumBedrooms',
            'Bedrooms',
            $this->makeList('MaxBedroom'),
            !empty($prop) ? $prop->NumBedrooms : null
        )->setEmptyString('Number of bedrooms'));

        $fields->push(DropdownField::create(
            'NumBathrooms',
            'Bathrooms',
            $this->makeList('MaxBathroom'),
            !empty($prop) ? $prop->NumBathrooms : null
        )->setEmptyString('Number of bathrooms'));

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
			)->setEmptyString('Myself'));
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

            $fields->push(HiddenField::create('ExistingGallery', 'ExistingGallery', implode(',' ,$prop->Gallery()->Column())));
            $fields->push(HiddenField::create('toDelete', 'toDelete'));
            $fields->push(HiddenField::create('PropertyID', 'PropertyID', $prop->ID));
        }

        $daily_charge = Config::inst()->get('PropertyPage', 'DailyCharge');

        $list_until = DateField::create('ListingCloseOn','Listing ends', !empty($prop) ? $prop->ListingCloseOn : null)->setDescription('Rate: $' . $daily_charge . ' per day.');

        if (!empty($prop)) {
            if ($prop->isPublished()) {
                $list_until = $list_until->setDescription(null)->performReadonlyTransformation();
            }

            if ($prop->hasPaid()) {
                $this->ListFree = true;
                $this->ListUntil = $prop->ListingCloseOn;
            } else {
                $this->Duration = $prop->ListingDuration;
                $this->AmountToPay = $daily_charge * $prop->ListingDuration;
            }

        }

        $fields->push($list_until);

        // ACTIONS -------------------------------------------------------------------------------------------------------------------
        $actions = new FieldList();

        $actions->push($btnWithdraw = FormAction::create('doWithdraw', 'Withdraw')->addExtraClass('red'));
        $actions->push($btnList = FormAction::create('doList', 'List it')->addExtraClass('green'));
		$actions->push(FormAction::create('doSubmit', !empty($prop) ? 'Save changes' : 'Create'));

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
            'ListingCloseOn'
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
                $this->addErrorMessage('ListingCloseOn', 'Listing end date cannot be earlier than today!');
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

                if ($property->hasPaid()) {
                    $property->writeToStage('Live');
                    return Controller::curr()->redirect('/member/action/' . ($this->Name == 'RentForm' ? 'list-property-for-rent' : 'list-property-for-sale') . '?property_id=' . $property->ID);
                } else {
                    $daily_charge = Config::inst()->get('PropertyPage', 'DailyCharge');
                    $amount = $daily_charge * $property->ListingDuration;
                    $payment = new Payment();
                    $payment->PaidByID = Member::currentUserID();
                    $payment->ValidUntil = $property->ListingCloseOn;

                    $payment->Amount->Amount = $amount;
                    $payment->OrderClass = 'PropertyPage';
                    $payment->OrderID = $property->ID;
                    $payment->write();
                    return;
                }
            }
        }

        return Controller::curr()->httpError(400);
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

    public function doSubmit($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {

            if (!empty($data['PropertyID'])) {
                $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($data['PropertyID']);
            } else {
                $property = new PropertyPage();
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

            if (empty($property->ListerID)) {
                $property->ListerID = Member::currentUserID();
            }

            $property->writeToStage('Stage');

            //return Controller::curr()->redirectBack();
            return Controller::curr()->redirect('/member/action/' . ($this->Name == 'RentForm' ? 'list-property-for-rent' : 'list-property-for-sale') . '?property_id=' . $property->ID);
        }

        return Controller::curr()->httpError(400);
    }



}

<?php

use SaltedHerring\Debugger;

class RentalListingForm extends Form
{
	public function __construct($controller)
    {
        $member = Member::currentUser();
        if (empty($member)) {
            return $controller->redirect('/signin');
        }

        $fields = new FieldList();
        $actions = new FieldList();

        $request = $controller->request;
        $propertyID =   $request->getVar('id');
        if ($listingID  =   $request->getVar('listing-id')) {

            $prop       =   Versioned::get_by_stage('RentalListing', 'Stage')->byID($listingID);

            $fields->push(
                HiddenField::create(
                    'ListingID',
                    'ListingID',
                    $listingID
                )
            );
        }

        if ($member->inGroup('realtors')) {
            if ($member->MemberOf()->exists()) {
                $fields->push(DropdownField::create(
                    'AgencyID',
                    'List as',
                    $member->MemberOf()->map('ID', 'Title'),
                    !empty($prop) ? $prop->AgencyID : null
                )->setEmptyString('Myself'));
            }

            $fields->push(
                TextField::create(
                    'AgencyReference',
                    'Agency reference',
                    !empty($prop) ? $prop->AgencyReference : null
                )->addExtraClass('agency-ref')
            );
        }

        $fields->push(TextField::create('ContactNumber', 'Contact number', !empty($prop) ? $prop->ContactNumber : $member->ContactNumber));

        $fields->push(TextField::create('WeeklyRent', 'Rent per week', !empty($prop) ? $prop->WeeklyRent : null)->setAttribute('placeholder', 'e.g. 768'));

        $fields->push(DateField::create('DateAvailable', 'Date available', !empty($prop) ? $prop->DateAvailable : null)->addExtraClass('use-dt-picker'));

        $fields->push(OptionsetField::create(
            'AllowPet',
            'Pet OK',
            array('No' => 'No', 'Yes' => 'Yes', 'Negotiable' => 'Negotiable'),
            !empty($prop) ? $prop->AllowPet : 'No'
        ));

        $fields->push(OptionsetField::create(
            'AllowSmoker',
            'Smoker OK',
            array('No' => 'No', 'Yes' => 'Yes'),
            !empty($prop) ? $prop->AllowSmoker : 'No'
        ));

        $fields->push($furnishings = TextareaField::create('Furnishings', 'Furnishing'));

        if (!empty($prop)) {
            $furnishings->setValue($prop->Furnishings);
        }

        $fields->push(DropdownField::create(
            'IdealTenants',
            'Ideal tenants',
            Config::inst()->get('Property', 'IdealTenants'),
            !empty($prop) ? $prop->IdealTenants : null
        )->setEmptyString('- select one -'));

        $fields->push(HiddenField::create(
            'PropertyID',
            'PropertyID',
            $propertyID
        ));

        $daily_charge   =   Config::inst()->get('Property', 'DailyCharge');
        $til_charge     =   Config::inst()->get('Property', 'TilRented');

        $listing_desc   =   'Rate: $' . $daily_charge . ' per day. ';

        $listingOption  =   OptionsetField::create(
            'ListTilGone',
            'Listing options',
            array(
                'By length: $' . $daily_charge .' per day',
                'List until rented: $' . $til_charge
            ),
            !empty($prop) ? $prop->ListTilGone : null
        );

        if (!empty($prop)) {
            if ($prop->isPaid) {
                $listingOption = LiteralField::create(
                    'DisplayListTil',
                    '<div class="list-until"><h3 class="title is-3">List until ' . $prop->getListTil() . '</h3><p class="subtitle is-6">You can no longer change this</p><br /></div>'
                );
            }
        }

        $fields->push($listingOption);

        $list_until = DateField::create('ListTilDate','Listing ends', !empty($prop) ? $prop->ListTilDate : null);

        $list_until
            ->setAttribute('data-daily-charge', $daily_charge)
            ->setAttribute('autocomplete', 'off')
            ->addExtraClass('use-dt-picker')
            ->setDescription('select date to work out the cost for listing.');
        if (!empty($prop) && $prop->isPaid) {

        } else {
            $fields->push($list_until);
        }

        if (!$request->isAjax()) {
            $actions->push(
                FormAction::create('doCancel', 'Cancel')->addExtraClass('pagination-previous is-warning')
            );
        }

        $list_label = 'List';

        if (!empty($prop)) {
            $list_label = $prop->isPaid ? 'Save' : 'List';
        }

        $actions->push(
            FormAction::create('doList', $list_label)->addExtraClass('pagination-next')
        );


        parent::__construct($controller, 'RentalListingForm', $fields, $actions);

        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', "RentalListingForm"));
    }

    public function doList($data, $form)
    {
        $listingID  =   !empty($data['ListingID']) ? $data['ListingID'] : null;
        $listing    =   !empty($listingID) ? (Versioned::get_by_stage('RentalListing', 'Stage')->byID($listingID)) : (new RentalListing());
        if (empty($listing->ID)) {
            $form->saveInto($listing);
        } else {
            foreach ($data as $key => $value) {
                if ($listing->hasField($key)) {
                    $listing->$key = $value;
                }
            }
        }

        $listing->writeToStage('Stage');

        if ($listing->isPaid) {
            $listing->writeToStage('Live');
        }

        if ($this->controller->request->isAjax()) {
            $order = SaltedOrder::prepare_order();
            $order->Amount->Amount = $listing->getAmount();

            $order->ListingID   =   $listing->ID;
            $link = $order->Pay('Paystation');

            return  json_encode(array(
                        'code'      =>  200,
                        'url'       =>  $link,
                        'then'      =>  'redirect'
                    ));
        }

        return $this->controller->redirectBack();
    }
}

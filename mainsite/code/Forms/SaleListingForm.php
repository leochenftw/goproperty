<?php

use SaltedHerring\Debugger;

class SaleListingForm extends Form
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
        $property_entity = Property::get()->byID($propertyID);
        if ($listingID  =   $request->getVar('listing-id')) {

            $prop       =   Versioned::get_by_stage('SaleListing', 'Stage')->byID($listingID);

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

        $fields->push(TextField::create(
            'FloorArea',
            'Floor area (m<sup>2</sup>)',
            !empty($property_entity) ? $property_entity->FloorArea : null
        ));

        $fields->push(TextField::create(
            'LandArea',
            'Land area (m<sup>2</sup>)',
            !empty($property_entity) ? $property_entity->LandArea : null
        ));

        // $fields->push(TextareaField::create('Content', 'Details', !empty($property_entity) ? $property_entity->Content : null));

        $fields->push(TextField::create('RateableValue', 'Rateable value', !empty($prop) ? $prop->RateableValue : null)->setAttribute('placeholder', 'e.g. 1,024,768'));

        $fields->push(CheckboxField::create('HideRV', 'Hide RV on listing', !empty($prop) ? $prop->HideRV : null));

        $fields->push(TextField::create('ExpectdSalePrice', 'Expected sale price', !empty($prop) ? $prop->ExpectdSalePrice : null)->setAttribute('placeholder', 'e.g. 1,024,768'));

        $fields->push(OptionsetField::create(
            'PriceOption',
            'Price option',
            array(
                'AskingPrice'           =>  'Asking price',
                'EnquiriesOver'         =>  'Enquiries over',
                'AuctionOn'             =>  'To be auctioned on',
                'TenderCloseOn'         =>  'Tenders closing on',
                'PriceByNegotiation'    =>  'Price by negotiation',
                'PrivateTreatyDeadline' =>  'Deadline Private Treaty by'
            ),
            empty($prop) ? 'AskingPrice' : $prop->PriceOption
        ));

        $fields->push($askprice = TextField::create(
            'AskingPrice',
            'Asking price',
            !empty($prop) ? $prop->AskingPrice : null
        ));

        $fields->push($enquryprice = TextField::create(
            'EnquiriesOver',
            'Enquiries over',
            !empty($prop) ? $prop->EnquiriesOver : null
        ));

        $fields->push($auctionon = DateField::create(
            'AuctionOn',
            'To be auctioned on',
            !empty($prop) ? $prop->AuctionOn : null
        )->addExtraClass('use-dt-picker'));

        $fields->push($tenderclose = DateField::create(
            'TenderCloseOn',
            'Tenders closing on',
            !empty($prop) ? $prop->TenderCloseOn : null
        )->addExtraClass('use-dt-picker'));

        $fields->push($deadline = DateField::create(
            'PrivateTreatyDeadline',
            'Deadline Private Treaty by',
            !empty($prop) ? $prop->PrivateTreatyDeadline : null
        )->addExtraClass('use-dt-picker'));

        $fields->push(
            DropdownField::create(
                'OpenHomeFrequency',
                'Open home schedule',
                array(
                    'On'            =>  'On',
                    'Every'         =>  'Every',
                    'Upon request'  =>  'Upon request'
                ),
                !empty($prop) ? $prop->OpenHomeFrequency : 'Upon request'
            )
        );

        $fields->push(
            DropdownField::create(
                'OpenHomeDays',
                '&nbsp;',
                array(
                    'Monday'    =>  'Monday',
                    'Tuesday'   =>  'Tuesday',
                    'Wednesday' =>  'Wednesday',
                    'Thursday'  =>  'Thursday',
                    'Friday'    =>  'Friday',
                    'Saturday'  =>  'Saturday',
                    'Sunday'    =>  'Sunday'
                ),
                !empty($prop) ? $prop->OpenHomeFrequency : null
            )->addExtraClass(!empty($prop) && $prop->OpenHomeFrequency == 'Every' ? '' : 'hide')
        );

        $fields->push(
            TextField::create(
                'OpenHomeTimes',
                '&nbsp;',
                !empty($prop) ? $prop->OpenHomeTimes : null
            )->addExtraClass('use-dt-picker use-time')
             ->addExtraClass(!empty($prop) && $prop->OpenHomeFrequency == 'On' ? '' : 'hide')
          );

        $fields->push(HiddenField::create(
            'PropertyID',
            'PropertyID',
            $propertyID
        ));


        $daily_charge   =   Config::inst()->get('Property', 'DailyCharge');
        $til_charge     =   Config::inst()->get('Property', 'TilSold');

        $listing_desc   =   'Rate: $' . $daily_charge . ' per day. ';

        $listingOption  =   OptionsetField::create(
            'ListTilGone',
            'Listing options',
            array(
                'By length: $' . $daily_charge .' per day',
                'List until sold: $' . $til_charge
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


        parent::__construct($controller, 'SaleListingForm', $fields, $actions);

        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', "SaleListingForm"));
    }

    public function doList($data, $form)
    {
        if (!empty($data['LandArea']) && !empty($data['FloorArea']) && !empty($data['PropertyID'])) {
            $property = Property::get()->byID($data['PropertyID']);
            $property->FloorArea = $data['FloorArea'];
            $property->LandArea = $data['LandArea'];
            $property->write();
        }

        $listingID  =   !empty($data['ListingID']) ? $data['ListingID'] : null;
        $listing    =   !empty($listingID) ? (Versioned::get_by_stage('SaleListing', 'Stage')->byID($listingID)) : (new SaleListing());

        if (empty($listing->ID)) {
            $form->saveInto($listing);
        } else {
            foreach ($data as $key => $value) {
                if ($listing->hasField($key)) {
                    $listing->$key = $value;
                }
            }
        }

        if ($dt = $data['OpenHomeTimes']) {
            $listing->OpenHomeTimes = strtotime($dt);
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

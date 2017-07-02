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
            !empty($prop) ? $prop->FloorArea : null
        ));

        $fields->push(TextField::create(
            'LandArea',
            'Land area (m<sup>2</sup>)',
            !empty($prop) ? $prop->LandArea : null
        ));

        $fields->push(TextareaField::create('Content', 'Details', !empty($prop) ? $prop->Content : null));

        $fields->push(TextField::create('RateableValue', 'Rateable value', !empty($prop) ? $prop->RateableValue : null)->setAttribute('placeholder', 'e.g. 1,024,768'));

        $fields->push(CheckboxField::create('HideRV', 'Hide RV on listing', !empty($prop) ? $prop->HideRV : null));

        $fields->push(TextField::create('ExpectdSalePrice', 'Expected sale price', !empty($prop) ? $prop->ExpectdSalePrice : null)->setAttribute('placeholder', 'e.g. 1,024,768'));

        $fields->push(OptionsetField::create(
            'PriceOption',
            'Price option',
            array(
                'Asking price'                  =>  'Asking price',
                'Enquiries over'                =>  'Enquiries over',
                'To be auctioned on'            =>  'To be auctioned on',
                'Tenders closing on'            =>  'Tenders closing on',
                'Price by negotiation'          =>  'Price by negotiation',
                'Deadline Private Treaty by'    =>  'Deadline Private Treaty by'
            ),
            empty($prop) ? 'Asking price' : $prop->PriceOption
        ));

        $fields->push($askprice = TextField::create(
            'AskingPrice',
            'Asking price',
            !empty($prop) ? $prop->AskingPrice : null
        )->addExtraClass('hide'));

        $fields->push($enquryprice = TextField::create(
            'EnquiriesOver',
            'Enquiries over',
            !empty($prop) ? $prop->EnquiriesOver : null
        )->addExtraClass('hide'));

        $fields->push($auctionon = DateField::create(
            'AuctionOn',
            'To be auctioned on',
            !empty($prop) ? $prop->AuctionOn : null
        )->addExtraClass('hide'));

        $fields->push($tenderclose = DateField::create(
            'TenderCloseOn',
            'Tenders closing on',
            !empty($prop) ? $prop->TenderCloseOn : null
        )->addExtraClass('hide'));

        if (!empty($prop)) {
            switch ($prop->PriceOption) {
                case 'AskingPrice':
                    $askprice->removeExtraClass('hide');
                    break;

                case 'EnquiriesOver':
                    $enquryprice->removeExtraClass('hide');
                    break;

                case 'AuctionOn':
                    $auctionon->removeExtraClass('hide');
                    break;

                case 'TenderCloseOn':
                    $tenderclose->removeExtraClass('hide');
                    break;

                case 'PriceByNegotiation':
                    // $negotiable->removeExtraClass('hide');
                    break;

                case 'PrivateTreatyDeadline':
                    $deadline->removeExtraClass('hide');
                    break;

                default:
                    $askprice->removeExtraClass('hide');
                    break;
            }
        } else {
            $askprice->removeExtraClass('hide');
        }

        $fields->push(
            DropdownField::create(
                'OpenHomeFrequency',
                '',
                array(
                    'On'            =>  'On',
                    'Every'         =>  'Every',
                    'Upon request'  =>  'Upon request'
                ),
                !empty($prop) ? $prop->OpenHomeFrequency : null
            )
        );


        $fields->push(DateField::create('OpenHomeTimes', 'Date available', !empty($prop) ? $prop->OpenHomeTimes : null)->addExtraClass('use-dt-picker'));

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

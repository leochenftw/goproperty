<?php

use SaltedHerring\Debugger;

class SaleForm extends PropertyForm
{
	public function __construct($controller, $prop = null)
    {
        parent::__construct($controller, 'SaleForm', $prop);
        $fields = parent::Fields();
        $actions = parent::Actions();

		$fields->push($title = TextField::create(
            'Title',
            'Title of listing',
            !empty($prop) ? $prop->Title : null
        )->setDescription('leave blank to use the address'));

        $fields->push(TextField::create('RateableValue', 'Rateable value', !empty($prop) ? $prop->RateableValue : null));

        $fields->push(CheckboxField::create(
            'HideRV',
            'Hide RV on listing',
            !empty($prop) ? $prop->HideRV : null
        ));

        $fields->push(TextField::create(
            'FloorArea',
            'Floor area',
            !empty($prop) ? $prop->FloorArea : null
        )->setDescription('m<sup>2</sup>'));

        $fields->push(TextField::create(
            'LandArea',
            'Land area',
            !empty($prop) ? $prop->LandArea : null
        )->setDescription('m<sup>2</sup>'));

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

        // $fields->push($negotiable = CheckboxField::create(
        //     'PriceByNegotiation',
        //     'Price by negotiation',
        //     !empty($prop) ? $prop->PriceByNegotiation : null
        // )->addExtraClass('hide'));

        $fields->push($deadline = DateField::create(
            'PrivateTreatyDeadline',
            'Deadline Private Treaty by',
            !empty($prop) ? $prop->PrivateTreatyDeadline : null
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

        $fields->changeFieldOrder(array(
            'PropertyType',
            'Title',
            'RateableValue',
            'HideRV',
            'Content',
            'NumBedrooms',
            'NumBathrooms',
            'SmokeAlarm',
            'Amenities',
            'Parking',
            'FloorArea',
            'LandArea',
            'ListingCloseOn'
        ));

        $this->setFormMethod('POST', true)
             ->setFormAction(Controller::join_links(BASE_URL, 'member', "SaleForm"));
    }
}

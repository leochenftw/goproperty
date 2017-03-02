<?php

use SaltedHerring\Debugger;
use Cocur\Slugify\Slugify;

class TradesmenSearchForm extends Form
{
    public function __construct($controller)
    {
        $agency = null;
        $fields = new FieldList();

        $fields->push(DropdownField::create(
            'Region',
            'Region',
            Config::inst()->get('NewZealand', 'Regions')
        )->setEmptyString('All New Zealand')->setAttribute('data-direct-child', 'TradesmenSearchForm_TradesmenSearchForm_City'));

        $fields->push(DropdownField::create(
            'City',
            'District'
        )->setEmptyString('All districts')->setAttribute('data-direct-child', 'TradesmenSearchForm_TradesmenSearchForm_Suburb'));

        $fields->push(DropdownField::create(
            'Suburb',
            'Suburb'
        )->setEmptyString('All suburbs'));

        $fields->push(DropdownField::create(
            'WorkType',
            'Work type',
            Service::get()->map('Slug', 'Title')
        )->setEmptyString('Any'));

        $actions = new FieldList();
        $actions->push(FormAction::create('doSearch', 'Search'));

        parent::__construct($controller, 'TradesmenSearchForm', $fields, $actions);
        $this->setFormMethod('POST', true)->addExtraClass('tradesmen-search-form')->addExtraClass('hide');
    }

    public function validate()
    {
         return true;
    }

    public function doSearch($data, $form)
    {
        if (!empty($data['SecurityID']) && $data['SecurityID'] == Session::get('SecurityID')) {
            $region     =   !empty($data['Region']) ? strtolower($data['Region']) : null;
            $district   =   !empty($data['City']) ? strtolower($data['City']) : null;
            $suburb     =   !empty($data['Suburb']) ? strtolower($data['Suburb']) : null;



            $url        =   '/tradesmen';

            $slugify = new Slugify();

            if (!empty($region)) {
                $region = $slugify->slugify($region);
                $url .= "/$region";
            }

            if (!empty($district)) {
                $district = $slugify->slugify($district);
                $url .= "/$district";
            }

            if (!empty($suburb)) {
                $suburb = $slugify->slugify($suburb);
                $url .= "/$suburb";
            }

            unset($data['Region']);
            unset($data['City']);
            unset($data['Suburb']);
            unset($data['SecurityID']);
            unset($data['action_doSearch']);

            $link = $url . '?';
            foreach ($data as $key => $value) {
                if (!empty($value)) {
                    if (is_array($value)) {
                        foreach ($value as $value_item) {
                            $link .= $key . '[]=' . $value_item . '&';
                        }
                    } else {
                        $link .= ($key . '=' . $value . '&');
                    }
                }
            }

            $link = rtrim(rtrim($link, '&'), '?');
            $url = $link;

            return $this->controller->redirect($url);

        }

        return $this->controller->httpError(400);
    }
}

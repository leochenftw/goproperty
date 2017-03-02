<?php
use SaltedHerring\Debugger;
class AddressSlugUpdator extends BuildTask
{
    protected $title = 'Address slug updator';
    protected $description = 'Update all address slugs';

    protected $enabled = true;

    public function run($request)
    {
        $members = Member::get();
        foreach ($members as $member)
        {
            $member->write();
        }

        $businesses = Business::get();
        foreach ($businesses as $business)
        {
            $business->write();
        }

        $properties = Versioned::get_by_stage('PropertyPage', 'Stage');
        foreach ($properties as $property)
        {
            $property->writeToStage('Stage');
            if ($live = Versioned::get_by_stage('PropertyPage', 'Live')->byID($property->ID)) {
                $property->writeToStage('Live');
            }
        }
    }
}

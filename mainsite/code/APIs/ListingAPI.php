<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file ListingAPI.php
 *
 * Controller to present the data from forms.
 * */
class ListingAPI extends BaseRestController {

    private $member     =   null;
    private $property   =   null;
    private $listing    =   null;

    private static $allowed_actions = array (
        'post'          =>  "->isAuthenticated",
        'get'			=>	false
    );

    public function isAuthenticated() {

        $request = $this->request;
        if ($this->member = Member::currentUser()) {
            if ($ID = $request->param('ID')) {

                $this->listing      =   Versioned::get_by_stage('Listing', 'Stage')->byID($ID);

                if ($this->listing->MemberID == $this->member->ID) {
                    $this->property =   $this->listing->Property();

                    return true;
                }
            }
        }

        return false;
    }

    public function post($request)
    {
        if ($request->param('Action') == 'end') {
            $this->listing->deleteFromStage('Live');
            return  array(
                        'code'      =>  200,
                        'message'   =>  'Finished'
                    );
        }

        if ($request->param('Action') == 'delete') {
            if (!$this->listing->isPaid) {
                $this->listing->deleteFromStage('Live');
                $this->listing->deleteFromStage('Stage');
                return  array(
                            'code'      =>  200
                        );
            }

            return  array(
                        'code'          =>  403,
                        'message'       =>  'You cannot delete a paid listing'
                    );
        }

        return  array(
                    'code'          =>  400,
                    'message'       =>  'action not allowed'
                );
    }

}

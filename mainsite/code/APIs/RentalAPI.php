<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file RentalAPI.php
 *
 * Controller to present the data from forms.
 * */
class RentalAPI extends BaseRestController {
    private $member     = null;
    private $property   = null;
    private $rental     = null;
    private static $allowed_actions = array (
        'post'          =>  "->isAuthenticated",
        'get'			=>	false
    );

    public function isAuthenticated() {

        $request        =   $this->request;
        $this->member   =   Member::currentUser();
        $sid            =   $request->postVar('SecurityID');
        $rentalID       =   $request->param('ID');
        $propertyID     =   $request->param('PROPERTYID');

        if ( $sid == Session::get('SecurityID') ) {
            if ($this->property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($propertyID)) {
                if ($this->property->ListerID == Member::currentUserID()) {
                    $this->rental = $this->property->Rentals()->byID($rentalID);
                    return !empty($this->rental);
                }
            }
        }

        return false;
    }

    public function post($request)
    {
        $this->rental->Terminated = true;
        $this->rental->write();

        return true;
    }

}

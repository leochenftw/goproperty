<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file ServiceRequestAPI.php
 *
 * Controller to present the data from forms.
 * */
class ServiceRequestAPI extends BaseRestController {
    private $member = null;
    private $business = null;
    private $srequest = null;
    private static $allowed_actions = array (
        'post'          =>  "->isAuthenticated",
        'get'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {

        $request = $this->request;
        if ($this->member = Member::currentUser()) {
            if ($sid = $this->getToken($request)) {
                if ( $sid == Session::get('SecurityID') ) {
                    if ($ID = $request->param('ID')) {
                        if ($request->isPost()) {
                            if ($this->interest = Interest::get()->byID($ID)) {
                                $this->business = $this->interest->business();
                                return $this->business->ID == $this->member->BusinessID;
                            }
                        }

                        if ($this->business = Business::get()->byID($ID)) {
                            return $this->business->ID == $this->member->BusinessID;
                        }
                    }
                }
            }
        }

        return false;
    }

    private function getToken($request)
    {
        return $request->isPost() ? $request->postVar('SecurityID') : $request->getVar('SecurityID');
    }

    public function post($request)
    {
        $this->interest->hasRead = true;
        $this->interest->write();
        if ($request->param('Action') == 'read') {
            return $this->interest->hasRead;
        }

        if ($request->param('Action') == 'accept') {
            $appointment = new Appointment();
            $appointment->BusinessID = $this->business->ID;
            $appointment->ClientID = $this->interest->MemberID;
            $appointment->write();

            return  array(
                        'code'              =>  200,
                        'appointment_id'    =>  $appointment->ID
                    );
        }

        return null;
    }

    public function get($request)
    {
        $list = array();
        if ($interests = $this->business->Interests()->filter(array('Expired:not' => true))) {
            $interests = $interests->sort(array('ID' => 'DESC'));
            foreach ($interests as $interest)
            {
                $list[] = $interest->getData();
            }
            return $list;
        }

		return 'no found';
    }
}

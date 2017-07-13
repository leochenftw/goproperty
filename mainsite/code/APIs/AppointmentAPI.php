<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file AppointmentAPI.php
 *
 * Controller to present the data from forms.
 * */
class AppointmentAPI extends BaseRestController {
    private $member = null;
    private $business = null;
    private $appointment = null;
    private static $allowed_actions = array (
        'post'          =>  "->isAuthenticated",
        'get'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {

        $request = $this->request;
        if ($this->member = Member::currentUser()) {

            if (!$this->member->inGroup('tradesmen')) {
                return false;
            }

            if ($sid = $this->getToken($request)) {
                if ( $sid == Session::get('SecurityID') ) {
                    if ($request->isPost()) {
                        if ($ID = $request->param('ID')) {
                            $this->appointment = Appointment::get()->byID($ID);
                            return $this->appointment->BusinessID == $this->member->BusinessID;
                        }
                    }

                    return true;
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

        if ($request->param('Action') == 'set-date') {
            $this->appointment->Date    =   $request->postVar('Date');
            $this->appointment->Memo    =   $request->postVar('Memo');
            $this->appointment->write();
            return true;
        }

        return null;
    }

    public function get($request)
    {
        $list = array();

        if (!empty($this->member->BusinessID)) {
            $business = $this->member->Business();
            $appointments = $business->Appointments();
            foreach ($appointments as $appointment)
            {
                $list[] = $appointment->getData();
            }
            return $list;
        }

		return array();
    }
}

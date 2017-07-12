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
                        // if ($request->isPost()) {
                        //     if ($this->interest = Interest::get()->byID($ID)) {
                        //         $this->business = $this->interest->business();
                        //         return $this->business->ListerID == $this->member->ID;
                        //     }
                        // }

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
            $rental = new Rental();
            $rental->Start = $request->postVar('Start');
            $rental->End = $request->postVar('End');
            $rental->UseNotice = $request->postVar('UseNotice');
            $rental->RenterID = $this->interest->MemberID;
            $rental->businessID  = $this->interest->businessID;
            $rental->write();

            $interests = $this->business->Interests()->filter(array('Expired:not' => true));

            foreach ($interests as $interest)
            {
                $interest->Expired = true;
                $interest->write();
            }

            $this->business->isGone = true;
            $this->business->isPaid = false;
            $this->business->writeToStage('Stage');
            $this->business->doUnpublish();
            return true;
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

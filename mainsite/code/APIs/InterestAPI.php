<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class InterestAPI extends BaseRestController {
    private $member = null;
    private $property = null;
    private $interest = null;
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
                                $this->property = $this->interest->Property();
                                return $this->property->ListerID == $this->member->ID;
                            }
                        }

                        if ($this->property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($ID)) {
                            return $this->property->ListerID == $this->member->ID;
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
            $rental->PropertyID  = $this->interest->PropertyID;
            $rental->write();
            $this->property->doUnpublish();
            $this->property->isGone = true;
            $this->property->isPaid = false;
            $this->property->writeToStage('Stage');
            return true;
        }

        return null;
    }

    public function get($request)
    {
        $list = array();
        if ($interests = $this->property->Interests()) {
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

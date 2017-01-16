<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class AgencyAPI extends BaseRestController {

    private static $allowed_actions = array (
        'post'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {

        $request = $this->request;
        $sid = !empty($request->postVar('SecurityID')) ? $request->postVar('SecurityID') : $request->getVar('SecurityID');

        if (!empty($sid) && $sid == Session::get('SecurityID')) {
            return true;
        }

        return false;
    }

    public function post($request) {
        if (empty($request->postVar('agency_id')) && !empty($request->postVar('agency_title'))) {
            return
                array(
                    'code'  =>  307,
                    'url'   =>  '/member/action/edit-agency?agency_title=' . $request->postVar('agency_title')
                );
        } else {
            if ($agency = Agency::get()->byID($request->postVar('agency_id'))) {
                $agency->Members()->add(Member::currentUserID());
                return
                    array(
                        'code'      =>  200,
                        'message'   =>  'You have successfully joined ' . $agency->Title
                    );
            }
        }

        return $this->httpError(400);
    }

    public function get($request) {
        return false;
    }
}

<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class AgencyAPI extends BaseRestController {

    private $agency     =   null;

    private static $allowed_actions = array (
        'post'			=>	"->isAuthenticated",
        'delete'        =>  "->isAuthenticated"
    );

    public function isAuthenticated() {

        $request        =   $this->request;
        if (!$request->isDelete()) {
            $sid            =   !empty($request->postVar('SecurityID')) ? $request->postVar('SecurityID') : $request->getVar('SecurityID');

            if (!empty($sid) && $sid == Session::get('SecurityID')) {
                return true;
            }
        } else {
            if ($this->agency = Agency::get()->byID($request->param('ID'))) {
                if ($this->agency->CreatedByID == Member::currentUserID()) {
                    return true;
                }
            }
        }

        return false;
    }

    public function delete($request)
    {
        return $this->agency->delete();
    }

    public function post($request)
    {
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

<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file Rating.php
 *
 * Controller to present the data from forms.
 * */
class OldPropertyAPI extends BaseRestController {

    private $propertyPage = null;
    private static $allowed_actions = array (
        'delete'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {

        $request = $this->request;
        $sid = !empty($request->postVar('SecurityID')) ? $request->postVar('SecurityID') : $request->getVar('SecurityID');
        $pid = $request->param('ID');
        $member = Member::currentUser();
        // if (!empty($sid) && $sid == Session::get('SecurityID') && !empty($member) && !empty($pid)) {
            if ($this->propertyPage = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($pid)) {
                return $this->propertyPage->ListerID == $member->ID;
            }

            return true;
        // }

        return false;
    }

    public function delete($request) {
        $this->propertyPage->doUnpublish();
        $this->propertyPage->Tinfoiled = true;
        return $this->propertyPage->writeToStage('Stage');
    }
}

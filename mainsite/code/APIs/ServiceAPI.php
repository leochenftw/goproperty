<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class ServiceAPI extends BaseRestController {

    private static $allowed_actions = array (
        'get'			=>	true
    );

    public function isAuthenticated() {

        $request = $this->request;
        if ($sid = $request->getVar('SecurityID')) {
            if ( $sid == Session::get('SecurityID')) {
                return true;
            }
        }

        return false;
    }

    public function get($request) {
        if ($slug = $request->param('Title')) {
            $services = Service::get()->filter(array('Title:PartialMatch' => $slug));
            $data = array();
            foreach($services as $service)
            {
                $data[] = array('id' => $service->ID, 'title' => $service->Title);
            }

            return $data;
        }
		return false;
    }
}

<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class LocationAPI extends BaseRestController {

    private static $allowed_actions = array (
        'get'			=>	true
    );

	public function get($request) {
		if ($distrct = $request->param('district')) {
            $districts = Config::inst()->get('New Zealand', $distrct);
            $data = array(
                'to'        =>  'Suburb',
                'options'   =>  array()
            );
            if ($suburb = $request->param('suburb')) {
                $suburbs = $districts[$suburb];
                foreach ($suburbs as $suburb)
                {
                    $data['options'][] = $suburb;
                }

                return $data;
            }

            $data['to'] = 'City';
            foreach ($districts as $key => $value) {
                $data['options'][] = $key;
            }

            return $data;
        }

		return false;
    }

}

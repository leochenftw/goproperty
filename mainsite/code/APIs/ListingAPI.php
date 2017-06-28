<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file ListingAPI.php
 *
 * Controller to present the data from forms.
 * */
class ListingAPI extends BaseRestController {

    private $member     =   null;
    private $property   =   null;
    private $listing    =   null;

    private static $allowed_actions = array (
        'post'          =>  "->isAuthenticated",
        'get'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {

        $request = $this->request;
        if ($this->member = Member::currentUser()) {
            if ($ID = $request->param('ID')) {

                $this->listing      =   Versioned::get_by_stage('Listing', 'Stage')->byID($ID);

                if ($this->listing->MemberID == $this->member->ID) {
                    $this->property =   $this->listing->Property();

                    return true;
                }
            }
        }

        return false;
    }

    public function get($request)
    {
        $action = $request->param('Action');

        if ($action == 'pay') {
            if (!$this->listing->isPaid) {

                $order = SaltedOrder::prepare_order();
                $order->Amount->Amount = $this->listing->getAmount();

                $order->ListingID   =   $this->listing->ID;
                $link = $order->Pay('Paystation');

                return  array(
                            'code'      =>  200,
                            'url'       =>  $link
                        );
            }

            return  array(
                        'code'          =>  403,
                        'message'       =>  'It\'s already been paid!'
                    );
        }

        return  array(
                    'code'          =>  400,
                    'message'       =>  'action not allowed'
                );
    }

    public function post($request)
    {
        $action = $request->param('Action');
        if ($action == 'end') {
            $this->listing->deleteFromStage('Live');
            return  array(
                        'code'      =>  200,
                        'message'   =>  'Finished'
                    );
        }

        if ($action == 'pay') {
            if (!$this->listing->isPaid) {
                $this->listing->deleteFromStage('Live');
                $this->listing->deleteFromStage('Stage');

                $order = SaltedOrder::prepare_order();
                $order->Amount->Amount = $this->listing->getAmount();

                $order->ListingID   =   $this->listing->ID;
                $order->Pay('Paystation');

                return  array(
                            'code'      =>  200,
                            'url'       =>  ''
                        );
            }

            return  array(
                        'code'          =>  403,
                        'message'       =>  'It\'s already been paid!'
                    );
        }

        if ($action == 'delete') {
            if (!$this->listing->isPaid) {
                $this->listing->deleteFromStage('Live');
                $this->listing->deleteFromStage('Stage');
                return  array(
                            'code'      =>  200
                        );
            }

            return  array(
                        'code'          =>  403,
                        'message'       =>  'You cannot delete a paid listing'
                    );
        }

        return  array(
                    'code'          =>  400,
                    'message'       =>  'action not allowed'
                );
    }

}

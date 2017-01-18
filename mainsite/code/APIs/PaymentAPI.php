<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class PaymentAPI extends BaseRestController {

    private static $allowed_actions = array (
        'post'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {

        $request = $this->request;
        $sid = !empty($request->postVar('SecurityID')) ? $request->postVar('SecurityID') : $request->getVar('SecurityID');

        if (!empty($sid) && $sid == Session::get('SecurityID')) {
            if ($payment_id = $request->param('ID')) {
                if ($payment = Payment::get()->byID($payment_id)){
                    return $payment->PaidByID == Member::currentUserID();
                }
            }
        }

        return false;
    }

    public function post($request) {
        if ($payment_id = $request->param('ID')) {
            if ($payment = Payment::get()->byID($payment_id)){
                $payment->Status = 'Cancelled';
                $payment->ProcessedAt = date('Y-m-d H:i:s');
                $payment->write();
                return
                    array(
                        'code'      =>  200,
                        'message'   =>  'Subscription has been cancelled',
                        'action'    =>  'refresh'
                    );
            }

            return $this->httpError(404);
        }

        return $this->httpError(400);
    }

    public function get($request) {
        return false;
    }
}

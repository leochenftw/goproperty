<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class CreditcardAPI extends BaseRestController {

    private static $allowed_actions = array (
        'post'			=>	"->isAuthenticated",
        'get'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {
        $request = $this->request;
        $sid = !empty($request->postVar('SecurityID')) ? $request->postVar('SecurityID') : $request->getVar('SecurityID');

        if (!empty($sid) && $sid == Session::get('SecurityID')) {
            if ($creditcard_id = $request->param('ID')) {
                if ($creditcard = StoredCreditcard::get()->byID($creditcard_id)) {
                    return $creditcard->MemberID == Member::currentUserID();
                }
            }
        }

        return false;
    }

    public function post($request)
    {
        if ($creditcard_id = $request->param('ID')) {
            $cards = StoredCreditcard::get();
            if ($creditcard = $cards->byID($creditcard_id)) {
                $owner_id = $creditcard->MemberID;
                $creditcard->delete();
                $remaining_cards = $cards->filter(array('MemberID' => $owner_id));

                if ($remaining_cards->count() == 1 && !$remaining_cards->first()->isPrimary) {
                    $remaining_cards->first()->isPrimary = true;
                    $remaining_cards->first()->write();
                }

                return
                    array(
                        'code'      =>  200,
                        'message'   =>  'creditcard has been deleted'
                    );
            }

            return $this->httpError(404);
        }

        return $this->httpError(400);
    }

    public function get($request)
    {
        if ($creditcard_id = $request->param('ID')) {
            if ($creditcard = StoredCreditcard::get()->byID($creditcard_id)) {
                return
                    array(
                        'code'          =>  200,
                        'card_type'     =>  $creditcard->getCardType(),
                        'card_number'   =>  $creditcard->CardNumber,
                        'card_expiry'   =>  $creditcard->formated_expiry()
                    );
            }
        }

        return $this->httpError(404);
    }
}

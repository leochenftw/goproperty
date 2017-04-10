<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class FavAPI extends BaseRestController {

    private static $allowed_actions = array (
        'get'           =>  false,
        'post'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {
        if ($member = Member::currentUser()) {
            return true;
        }
        return false;
    }

    public function post($request) {

        $class = $request->postVar('class');
        $id = $request->postVar('id');

        if (!empty($class) && !empty($id)) {
            if ($member = Member::currentUser()) {
                $item = $member->Wishlist()->filter(array('TargetClass' => $class, 'TargetID' => $id));
                $message = array('message' => 'Error occured', 'status' => false, 'css_class' => null);
                if ($item->count() > 0) {
                    $item->first()->delete();
                    $message['message'] = 'Removed from the wishlist';
                    $message['status'] = true;
                    $message['css_class'] = 'icon-heart-empty';
                    $message['html'] = 'Wishlist';
                } else {
                    $item = new WishlistItem();
                    $item->TargetClass = $class;
                    $item->TargetID = $id;
                    $item->MemberID = $member->ID;
                    $item->write();
                    $message['message'] = 'Added to the wishlist';
                    $message['status'] = true;
                    $message['css_class'] = 'icon-heart';
                    $message['html'] = 'Wishlisted';
                }

                return $message;
            }
        }

        return $this->httpError(400);
    }

    public function get($request) {
        return false;
    }
}

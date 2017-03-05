<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file Rating.php
 *
 * Controller to present the data from forms.
 * */
class RatingAPI extends BaseRestController {

    private static $allowed_actions = array (
        'get'           =>  true,
        'post'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {

        $request = $this->request;
        $sid = !empty($request->postVar('sid')) ? $request->postVar('sid') : $request->getVar('sid');
        $member = Member::currentUser();
        if (!empty($sid) && $sid == Session::get('SecurityID') && !empty($member)) {

            return true;
        }

        return false;
    }

    public function post($request) {
        if ($id = $request->param('memberID')) {
            if ($stars = $request->postVar('stars')) {
                $member = Member::get()->byID($id);

                $rating = Rating::get()->filter(array('GiverID' => Member::currentUserID(), 'TakerID' => $id))->first();
                if (!empty($rating)) {
                    if ($rating->Stars == $stars) {
                        $rating->delete();
                        return array(
                                        'message'   =>  'rating withdrawn',
                                        'stars'     =>  $member->getRating(),
                                        'html'      =>  $member->getRating(true)
                                    );
                    }
                } else {
                    $rating = new Rating();
                }
                $rating->Stars = $stars;
                $rating->TakerID = $id;
                $rating->write();
                return array(
                                'message'   =>  'rated',
                                'stars'     =>  $member->getRating(),
                                'html'      =>  $member->getRating(true)
                            );
            }
        }

        return $this->httpError(400);
    }
}

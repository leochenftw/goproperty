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

    public function get($request)
    {
        if ($type = $request->param('Type')) {
            if ($id = $request->param('ID')) {
                if ($type == 'Member') {
                    $member = Member::get()->byID($id);
                    $ratings = $member->BeingRated();
                    $json = array();
                    foreach ($ratings as $rating)
                    {
                        $json[] = $rating->getData();
                    }

                    return $json;
                } elseif ($type == 'PropertyPage') {

                }
            }
        }

        return $this->httpError(404, 'no such person/property exists');
    }

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
        if ($type = $request->param('Type')) {
            if ($id = $request->param('ID')) {
                if ($stars = $request->postVar('stars')) {
                    if ($type == 'Member') {
                        return $this->handleMemberRating($id, $stars);
                    } elseif ($type == 'PropertyPage') {
                        return $this->handlePropertyRating($id, $stars);
                    }
                }
            }
        }

        return $this->httpError(400);
    }

    private function handlePropertyRating($id, $stars)
    {
        if ($property = PropertyPage::get()->byID($id)) {
            $rating = Rating::get()->filter(array('GiverID' => Member::currentUserID(), 'PropertyID' => $id))->first();

            if (!empty($rating)) {
                if ($rating->Stars == $stars) {
                    $rating->delete();
                    $PropertyRatings = $property->getRating();
                    return array(
                                'message'   =>  'rating withdrawn',
                                'count'     =>  $PropertyRatings->Count,
                                'html'      =>  $PropertyRatings->HTML
                            );
                }
            } else {
                $rating = new Rating();
                $rating->PropertyID = $id;
            }

            $rating->Stars = $stars;

            $rating->write();

            $PropertyRatings = $property->getRating();

            return array(
                        'message'   =>  'rated',
                        'count'     =>  $PropertyRatings->Count,
                        'html'      =>  $PropertyRatings->HTML
                    );
        }

        return array();
    }

    private function handleMemberRating($id, $stars)
    {
        $member = Member::get()->byID($id);
        $rating = Rating::get()->filter(array('GiverID' => Member::currentUserID(), 'TakerID' => $id))->first();

        if (!empty($rating)) {
            if ($rating->Stars == $stars) {
                $rating->delete();
                $MemberRatings = $member->getRating();
                return array(
                            'message'   =>  'rating withdrawn',
                            'count'     =>  $MemberRatings->Count,
                            'html'      =>  $MemberRatings->HTML
                        );
            }
        } else {
            $rating = new Rating();
            $rating->TakerID = $id;
        }

        $rating->Stars = $stars;

        $rating->write();
        $MemberRatings = $member->getRating();
        return array(
                    'message'   =>  'rated',
                    'count'     =>  $MemberRatings->Count,
                    'html'      =>  $MemberRatings->HTML
                );
    }
}

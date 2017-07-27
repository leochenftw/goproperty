<?php
use SaltedHerring\Debugger;

class FeedbackInvitationController extends Page_Controller
{
    private $ratingID       =   null;
    private $ratingTarget   =   null;
    private $rateWhat       =   'property';
    private $ratingObject   =   null;
    private $used           =   false;
    /**
     * Defines methods that can be called directly
     * @var array
     */
    private static $allowed_actions = array(
        'FeedbackForm'
    );

    public function FeedbackForm()
    {
        if ($this->used) {
            return null;
        }
        return new FeedbackForm($this, $this->ratingID, $this->rateWhat);
    }

    public function getCoodinates()
    {
        return $this->ratingTarget;
    }

    public function getFeedbackTo()
    {
        if ($this->ratingTarget->ClassName == 'PropertyPage') {
            return '<strong>Propety</strong>: ' . $this->ratingTarget->FullAddress;
        }

        if (!empty($this->ratingObject->TargetRole)) {

            if ($this->ratingObject->TargetRole == 'Tradesperson') {
                $name = $this->ratingTarget->Business()->Title;
            } else {
                $name = $this->ratingTarget->FirstName . ' ' . $this->ratingTarget->Surname;
            }

            return "<strong>" . $this->ratingObject->TargetRole . "</strong>: " . $name;
        }

        return '<strong>Tenant</strong>: ' . $this->ratingTarget->FirstName . ' ' . $this->ratingTarget->Surname;
    }

    public function index()
    {
        $member         =   Member::currentUser();

        $request        =   $this->request;
        $this->ratingID =   $request->param('ID');
        $key            =   $request->getVar('key');

        $rating         =   Rating::get()->byID($this->ratingID);

        if (!empty($rating->GiverEmail)) {
            return $this->redirect('/signup?BackURL=' . $this->Link() . '/' . $this->ratingID . '?key=' . $key . '&email=' . $rating->GiverEmail);
        }

        if (!empty($key) && !empty($this->ratingID)) {

            if (empty($member)) {
                return $this->redirect('/signin?BackURL=' . $this->Link() . '/' . $this->ratingID . '?key=' . $key);
            }

            $this->ratingObject = $rating;

            if ($rating->GiverID != $member->ID) {
                return $this->httpError(403, 'This is not for you');
            }

            if (!empty($rating->TakerID)) {
                $this->rateWhat = $this->ratingObject->TargetRole;
            }

            $this->used = empty($rating->Key);

            $this->ratingTarget = !empty($rating->TakerID) ? $rating->Taker() : Versioned::get_by_stage('PropertyPage', 'Stage')->byID($rating->PropertyID);

            return $this->renderWith(array('FeedbackPage', 'Page'));
        }

        return $this->httpError(404);
    }

    public function Link($action = null)
    {
        return '/feedback';
    }

    public function Title()
    {
        return 'Provide your feedback';
    }

    public function flushMessage()
    {
        Session::clear("FormInfo");
    }
}

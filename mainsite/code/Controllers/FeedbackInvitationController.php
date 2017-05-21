<?php
use SaltedHerring\Debugger;

class FeedbackInvitationController extends Page_Controller
{
    private $ratingID       =   null;
    private $ratingTarget   =   null;
    private $rateWhat       =   'property';
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

        return '<strong>Tenant</strong>: ' . $this->ratingTarget->FirstName . ' ' . $this->ratingTarget->Surname;
    }

    public function index()
    {
        $member         =   Member::currentUser();

        $request        =   $this->request;
        $this->ratingID =   $request->param('ID');
        $key            =   $request->getVar('key');

        if (!empty($key) && !empty($this->ratingID)) {

            if (empty($member)) {
                return $this->redirect('/signin?BackURL=' . $this->Link() . '/' . $this->ratingID . '?key=' . $key);
            }

            $rating     =   Rating::get()->byID($this->ratingID);

            if ($rating->GiverID != $member->ID) {
                return $this->httpError(403, 'This is not for you');
            }

            if (!empty($rating->TakerID)) {
                $this->rateWhat = 'Tradeperson';
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

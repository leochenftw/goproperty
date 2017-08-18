<?php
use Ntb\RestAPI\BaseRestController as BaseRestController;
use SaltedHerring\Debugger as Debugger;
/**
 * @file SiteAppController.php
 *
 * Controller to present the data from forms.
 * */
class InvitationAPI extends BaseRestController {

    private $email      =   null;
    private $property   =   null;

    private static $allowed_actions = array (
        'get'           =>  false,
        'post'			=>	"->isAuthenticated"
    );

    public function isAuthenticated() {
        if ($member = Member::currentUser()) {
            if (($propertyID = $this->request->postVar('propertyID')) &&
                ($this->email = $this->request->postVar('email')) &&
                ($csrf = $this->request->postVar('csrf')))
            {
                if ($csrf == Session::get('SecurityID')) {
                    if ($this->property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($propertyID)) {
                        return $this->property->ListerID == Member::currentUserID();
                    }
                }
            }
        }

        return false;
    }

    public function post($request) {
        $rating                     =   new Rating();
        $rating->Key                =   sha1(mt_rand() . mt_rand());

        $agent                      =   Agency::get()->byID($this->agentID);

        $rating->TakerID            =   Member::currentUserID();
        $rating->TargetRole         =   'Realtor';

        if ($member = Member::get()->filter(array('Email' => $this->email))->first()) {
            $rating->GiverID        =   $member->ID;
            $rating->write();
            $invitation             =   new FeedbackInvitation($rating->Giver(), 'Buyer', $rating);
        } else {
            $rating->GiverEmail     =   $this->email;
            $rating->write();
            $invitation             =   new FeedbackRequester($this->email, $rating);
        }

        $invitation->send();

        $this->property->deleteFromStage('Live');
        $this->property->isGone     =   true;
        $this->property->Tinfoiled  =   true;
        $this->property->writeToStage('Stage');

        return true;
    }

    public function get($request) {
        return false;
    }
}

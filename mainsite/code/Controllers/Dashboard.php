<?php use SaltedHerring\Debugger as Debugger;

class Dashboard extends Page_Controller {
	private static $url_handlers = array(
		''				=>	'index',
		'action/$tab'	=>	'index'
	);

	private static $allowed_actions = array(
		'index',
		'signout',
		'MemberProfileForm',
		'UpdatePasswordForm',
		'UpdateEmailForm',
        'isValidated'
	);

	public function index($request) {
		if (!Member::currentUser()) {
			return $this->redirect('/signin?BackURL=/member');
		}
		$tab = $request->param('tab');
		if ($request->isAjax()) {
			switch ($tab) {

				case 'password':
					return $this->customise(array('tab' => $tab))->renderWith(array('UpdatePasswordForm'));
					break;

				case 'email-update':
					return $this->customise(array('tab' => $tab))->renderWith(array('UpdateEmailForm'));
					break;

				default:
					return $this->customise(array('tab' => $tab))->renderWith(array('MemberProfileForm'));
			}
		}

		return $this->customise(array('tab' => $tab))->renderWith(array('Dashboard', 'Page'));
	}

	public function signout() {
		if ($member = Member::currentUser()) {
			$member->logOut();
		}

		$this->redirect('/');
	}

	public function MemberProfileForm() {
		return new MemberProfileForm($this);
	}

	public function UpdatePasswordForm() {
		return new UpdatePasswordForm($this);
	}

	public function UpdateEmailForm() {
		return new UpdateEmailForm($this);
	}

    public function Link($action = NULL) {
		return 'member';
	}

	public function Title() {
		return 'Dashboard';
	}

    public function EmailisValidated()
    {
        return empty(Member::currentUser()->ValidationKey);
    }    
}

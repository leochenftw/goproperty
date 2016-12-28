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
		'YoGoldPurchaseForm',
		'MiniSubscribeForm'
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

				case 'address':
					return $this->customise(array('tab' => $tab))->renderWith(array('MyAddresses'));
					break;

				case 'yo-gold':
					return $this->customise(array('tab' => $tab))->renderWith(array('YoGoldPurchaseForm'));
					break;

				case 'orders':
					return $this->customise(array('tab' => $tab))->renderWith(array('OrderHistory'));
					break;

				case 'favourites':
					return $this->customise(array('tab' => $tab))->renderWith(array('FavouritesList'));
					break;
				case 'watch':
					return $this->customise(array('tab' => $tab))->renderWith(array('MyWatch'));
					break;
				default:
					return $this->customise(array('tab' => $tab))->renderWith(array('MemberProfileForm'));
			}
		}

		return $this->customise(array('tab' => $tab))->renderWith(array('Dashboard', 'Page'));
	}

	public function getFavourites() {
		if ($member = Member::currentUser()) {
			return $member->Favourites();
		}

		return Favourite::get()->filter(array('Session' => session_id()));
	}

	public function getWatchlist() {
		if ($member = Member::currentUser()) {
			return $member->Watchlist();
		}

		return null;
	}

	public function getSubscribe() {
		if ($member = Member::currentUser()) {
			return $member->Subscribe;
		}

		return false;
	}

	public function signout() {
		if ($member = Member::currentUser()) {
			$member->logOut();
		}

		$this->redirect('/');
	}

	// public function MemberProfileForm() {
	// 	return new MemberProfileForm($this);
	// }
    //
	// public function UpdatePasswordForm() {
	// 	return new UpdatePasswordForm($this);
	// }
    //
	// public function UpdateEmailForm() {
	// 	return new UpdateEmailForm($this);
	// }
    //
	// public function YoGoldPurchaseForm() {
	// 	return new YoGoldPurchaseForm($this);
	// }
    //
	// public function MiniSubscribeForm($watch_id) {
	// 	return new MiniSubscribeForm($this, $watch_id);
	// }

    public function Link($action = NULL) {
		return 'member';
	}

	public function Title() {
		return 'My profiles';
	}
}

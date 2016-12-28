<?php
use SaltedHerring\Debugger;

class Signin extends Page_Controller
{
    private static $allowed_actions = array(
        'index',
        'SigninForm'
    );

    public function index($request) {
        $curr_member = Member::currentUser();
        $backURL = $request->getVar('BackURL') ? $request->getVar('BackURL') : '/member';

        if ($curr_member) {
            $this->redirect($backURL);
        }
        return $this->renderWith(array('Signin', 'Page'));
    }

    public function SigninForm() {
        return new SigninForm($this, 'SigninForm');
    }

    public function Link($action = NULL) {
		return 'signin';
	}

    public function Title() {
        return 'Signin';
    }
}

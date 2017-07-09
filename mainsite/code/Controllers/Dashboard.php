<?php use SaltedHerring\Debugger as Debugger;

class Dashboard extends Page_Controller {

    protected $Member = null;

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
        //'PropertyForm',
        'RentForm',
        'SaleForm',
        'AccountUpgradeForm',
        'MembershipExtendingForm',
        'addCreditcardForm',
        'AgencyForm',
        'BusinessForm',
        'VoucherForm',
        'CreatePropertyForm',
        'RentalListingForm',
        'SaleListingForm'
    );

    public function index($request) {
        if (!Member::currentUser()) {
            return $this->redirect('/signin?BackURL=/member');
        }

        $member = Member::currentUser();

        $this->Member = $member;
        $tab = $request->param('tab');

        if ($member->ChangePassOnNextLogin && $tab != 'password') {
            return $this->redirect('/member/action/password');
        }

        if (!empty($member->SignupFrom)) {
            $toURL = $member->SignupFrom;
            $member->SignupFrom = null;
            $member->write();
            return $this->redirect($toURL);
        }

        if (($member->beLandlords || $member->beTradesmen || $member->beRealtors) && $tab != 'upgrade' && $tab != 'signout'){
            return $this->redirect('/member/action/upgrade');
        }

        if (($tab == 'list-property-for-sale' || $tab == 'agencies') && !$this->isAgent()) {
            return $this->redirect('/member/action/upgrade');
        }

        if ($tab == 'list-property-for-rent' && !$this->isAgent() && !$this->isLandlord()) {
            return $this->redirect('/member/action/upgrade');
        }

        if ($tab == 'my-business' && !$this->isTradesperson()) {
            return $this->redirect('/member/action/upgrade');
        }

        if ($request->isAjax()) {

            switch ($tab) {
                case 'properties':
                    return $this->customise(array('tab' => $tab))->renderWith(array('NeoProperties'));
                    break;

                case 'sale-listing':
                    return $this->customise(array('tab' => $tab))->renderWith(array('SaleListingForm'));
                    break;

                case 'sale-listings':
                    $id = $request->getVar('id');
                    $property = Property::get()->byID($id);
                    return $this->customise(array('tab' => $tab, 'Property' => $property))->renderWith(array('SaleListings'));
                    break;

                case 'rental-listing':
                    return $this->customise(array('tab' => $tab))->renderWith(array('RentalListingForm'));
                    break;

                case 'rental-listings':
                    $id = $request->getVar('id');
                    $property = Property::get()->byID($id);
                    return $this->customise(array('tab' => $tab, 'Property' => $property))->renderWith(array('RentalListings'));
                    break;

                case 'manage-property':
                    return $this->customise(array('tab' => $tab, 'isAjax' => true))->renderWith(array('NeoPropertyForm'));
                    break;

                case 'my-business':
                    return $this->customise(array('tab' => $tab))->renderWith(array('MyBusiness'));
                    break;

                case 'my-properties':
                    return $this->customise(array('tab' => $tab))->renderWith(array('MyProperties'));
                    break;

                case 'payment-history':
                    return $this->customise(array('tab' => $tab))->renderWith(array('PaymentHistory'));
                    break;

                case 'creditcards':
                    return $this->customise(array('tab' => $tab))->renderWith(array('Creditcards'));
                    break;

                case 'agencies':
                    return $this->customise(array('tab' => $tab))->renderWith(array('Agencies'));
                    break;

                case 'edit-agency':
                    return $this->customise(array('tab' => $tab))->renderWith(array('AgencyForm'));
                    break;

                case 'password':
                    return $this->customise(array('tab' => $tab))->renderWith(array('UpdatePasswordForm'));
                    break;

                case 'email-update':
                    return $this->customise(array('tab' => $tab))->renderWith(array('UpdateEmailForm'));
                    break;

                case 'list-property-for-rent':
                    return $this->customise(array('tab' => $tab))->renderWith(array('PropertyForm'));
                    break;

                case 'list-property-for-sale':
                    return $this->customise(array('tab' => $tab))->renderWith(array('PropertyForm'));
                    break;

                case 'upgrade':
                    return $this->customise(array('tab' => $tab))->renderWith(array('AccountUpgradeForm'));
                    break;

                case 'cancel-subscription':
                    return $this->customise(array('tab' => $tab))->renderWith(array('SubscriptionManager'));
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

    public function MembershipExtendingForm()
    {
        return new MembershipExtendingForm($this);
    }

    public function AgencyForm()
    {
        return new AgencyForm($this);
    }

    public function addCreditcardForm()
    {
        return new addCreditcardForm($this);
    }

    public function AccountUpgradeForm()
    {
        return new AccountUpgradeForm($this);
    }

    public function MemberProfileForm()
    {
        return new MemberProfileForm($this);
    }

    public function UpdatePasswordForm()
    {
        return new UpdatePasswordForm($this);
    }

    public function UpdateEmailForm()
    {
        return new UpdateEmailForm($this);
    }

    public function RentForm()
    {
        $property = null;
        if ($prop_id = $this->request->getVar('property_id')) {
            $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($prop_id);
            if (empty($property)) {
                return $this->httpError(404);
            }
        }

        if (!empty($property->RentOrSale) && $property->RentOrSale != 'rent') {
            $this->redirect('/member/action/list-property-for-sale?property_id=' . $prop_id);
            return;
        }

        return new RentForm($this, $property);
    }

    public function SaleForm()
    {
        $property = null;
        if ($prop_id = $this->request->getVar('property_id')) {
            $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($prop_id);
            if (empty($property)) {
                return $this->httpError(404);
            }

            if (!empty($property->RentOrSale) && $property->RentOrSale != 'sale') {
                $this->redirect('/member/action/list-property-for-rent?property_id=' . $prop_id);
                return;
            }
        }

        return new SaleForm($this, $property);
    }

    public function BusinessForm()
    {
        $member = Member::currentUser();
        $business = $member->Business()->exists() ? $member->Business() : null;
        return new BusinessForm($this, $business);
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

    public function getExistings()
    {
        $request = $this->controller->request;
        Debugger::inspect($request);
        return null;
    }

    public function getProperties()
    {
        if (!empty($this->Member)) {
            return $this->Member->Properties();
        }

        return null;
    }

    public function getMyProperties()
    {
        $properties = Versioned::get_by_stage('PropertyPage', 'Stage')->filter(array('Tinfoiled:not' => true, 'ListerID' => Member::currentUserID()));

        return $properties;
    }

    public function getMyWishlist()
    {
        if ($member = Member::currentUser()) {
            $list = new ArrayList();

            $wishlist = $member->Wishlist();
            foreach ($wishlist as $wishlistitem)
            {
                $classname = $wishlistitem->TargetClass;
                $id = $wishlistitem->TargetID;

                $item = $classname::get()->byID($id);
                if ($item) {
                    $list->add($item);
                }
            }

            return $list;
        }

        return null;
    }

    public function isAgent()
    {
        if ($member = Member::currentUser()) {
            return $member->isAgent();
        }

        return false;
    }

    public function isLandlord()
    {
        if ($member = Member::currentUser()) {
            return $member->isLandlord();
        }

        return false;
    }

    public function isTradesperson()
    {
        if ($member = Member::currentUser()) {
            return $member->isTradesperson();
        }

        return false;
    }

    public function getAgencies()
    {
        if ($member = Member::currentUser()) {
            return $member->MemberOf();
        }

        return null;
    }

    public function getCreditcards()
    {
        if ($member = Member::currentUser()) {
            return $member->Creditcards();
        }

        return null;
    }

    public function getSubscription()
    {
        if ($member = Member::currentUser()) {
            return $member->getSubscription();
        }

        return null;
    }

    public function getPaymentHistory()
    {
        if ($member = Member::currentUser()) {
            //return $member->getPaymentHistory();
            return Payment::get()->filter(array('PaidByID' => $member->ID, 'Status:not' => 'Pending', 'Status:not' => 'Incomplete'))->where('Status IS NOT NULL');
        }

        return null;
    }

    public function getActiveSubscription()
    {
        if ($member = Member::currentUser()) {
            return $member->getActiveSubscription();
        }

        return null;
    }

    public function NeedsToPay()
    {
        if ($member = Member::currentUser()) {
            return $member->NeedsToPay();
        }

        return false;
    }

    public function VoucherForm()
    {
        return new VoucherForm($this);
    }

    public function SaleListingForm()
    {
        return new SaleListingForm($this);
    }

    public function RentalListingForm()
    {
        return new RentalListingForm($this);
    }

    public function CreatePropertyForm()
    {
        return new CreatePropertyForm($this);
    }

    public function canUseVoucher()
    {
        $member = Member::currentUser();
        if (!empty($member->FreeUntil)) {
            return false;
        }
        return empty(Voucher::get()->filter(array('MemberID' => $member->ID))->first()) ? true : false;
    }

    public function isCreatingProperty()
    {
        return $this->request->getURL() == 'member/action/manage-property' && empty($this->request->getVar('id'));
    }
}

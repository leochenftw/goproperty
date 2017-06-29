<?php
use SaltedHerring\Debugger;
use SaltedHerring\Utilities as Utilities;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;
class Page extends SiteTree {

    private static $db = array(
        'NarrowContainer'   =>  'Boolean'
    );

    private static $has_one = array(
    );

    public function getCMSFields()
    {
        $fields             =   parent::getCMSFields();
        $fields->addFieldToTab(
            'Root.Main',
            CheckboxField::create(
                'NarrowContainer',
                'Narrow the page width to 600px'
            ),
            'Title'
        );
        return $fields;
    }
}
class Page_Controller extends ContentController {
    protected static $extensions = array(
        'SiteJSControllerExtension'
    );
    /**
     * An array of actions that can be accessed via a request. Each array element should be an action name, and the
     * permissions or conditions required to allow the user to access it.
     *
     * <code>
     * array (
     *     'action', // anyone can access this action
     *     'action' => true, // same as above
     *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
     *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
     * );
     * </code>
     *
     * @var array
     */
    private static $allowed_actions = array (
        'PropertySearchForm',
        'TradesmenSearchForm',
        'Form'
    );

    public function init() {
        // Debugger::inspect(SS_ENVIRONMENT_TYPE);
        // Debugger::inspect(Config::inst()->get('SaltedPayment', 'MerchantSettings'));
        parent::init();
        Requirements::block(THIRDPARTY_DIR . '/jquery-ui-themes/smoothness/jquery-ui.css');
        Requirements::block('framework/css/UploadField.css');
        Requirements::block(THIRDPARTY_DIR . '/jquery/jquery.js');
        Requirements::block(THIRDPARTY_DIR . '/jquery-ui/jquery-ui.js');
        Requirements::block(THIRDPARTY_DIR . '/jquery-entwine/dist/jquery.entwine-dist.js');
        Requirements::block('framework/admin/javascript/ssui.core.js');
        Requirements::block('framework/javascript/i18n.js');
        Requirements::block('framework/javascript/lang/en.js');
        Requirements::block('framework/javascript/UploadField_uploadtemplate.js');
        Requirements::block('framework/javascript/UploadField_downloadtemplate.js');
        Requirements::block('framework/javascript/UploadField.js');


        Requirements::block(THIRDPARTY_DIR . '/javascript-templates/tmpl.js');
        Requirements::block(THIRDPARTY_DIR . '/javascript-loadimage/load-image.js');
        Requirements::block(THIRDPARTY_DIR . '/jquery-fileupload/jquery.iframe-transport.js');
        Requirements::block(THIRDPARTY_DIR . '/jquery-fileupload/cors/jquery.xdr-transport.js');
        Requirements::block(THIRDPARTY_DIR . '/jquery-fileupload/jquery.fileupload.js');
        Requirements::block(THIRDPARTY_DIR . '/jquery-fileupload/jquery.fileupload-ui.js');

        // Note: you should use SS template require tags inside your templates
        // instead of putting Requirements calls here.  However these are
        // included so that our older themes still work
        /*
Requirements::themedCSS('reset');
        Requirements::themedCSS('layout');
        Requirements::themedCSS('typography');
        Requirements::themedCSS('form');
*/
        $this->initJS();
        // $pay_link = Paystation::process(10, 'MembershipSubscription', (session_id() . '-' . time()));
        // Debugger::inspect($pay_link);
    }

    protected function getSessionID() {
        return session_id();
    }

    protected function getHTTPProtocol() {
        $protocol = 'http';
        if (isset($_SERVER['SCRIPT_URI']) && substr($_SERVER['SCRIPT_URI'], 0, 5) == 'https') {
            $protocol = 'https';
        } elseif (isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) == 'on') {
            $protocol = 'https';
        }
        return $protocol;
    }

    protected function getCurrentPageURL() {
        return $this->getHTTPProtocol().'://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
    }

    public function MetaTags($includeTitle = true) {
        $tags = parent::MetaTags();

        /**
         * Find title & replace with MetaTitle (if it exists).
         * */
        $title = '/(\<title\>)(.*)(\<\/title\>)/';
        preg_match($title, $tags, $matches);

        if (count($matches) > 0) {
            if ($this->MetaTitle) {
                $tags = preg_replace($title, '$1' . $this->MetaTitle . '$3', $tags);
            }
        }

        $charset = ContentNegotiator::get_encoding();
        $tags .= "<meta http-equiv=\"Content-type\" content=\"text/html; charset=$charset\" />\n";
        if($this->MetaKeywords) {
            $tags .= "<meta name=\"keywords\" content=\"" . Convert::raw2att($this->MetaKeywords) . "\" />\n";
        }
        if($this->ExtraMeta) {
            $tags .= $this->ExtraMeta . "\n";
        }

        if($this->URLSegment == 'home' && SiteConfig::current_site_config()->GoogleSiteVerificationCode) {
            $tags .= '<meta name="google-site-verification" content="'
                    . SiteConfig::current_site_config()->GoogleSiteVerificationCode . '" />\n';
        }

        // prevent bots from spidering the site whilest in dev.
        if(!Director::isLive()) {
            $tags .= "<meta name=\"robots\" content=\"noindex, nofollow, noarchive\" />\n";
        }

        $this->extend('MetaTags', $tags);

        return $tags;
    }

    public function getTheTitle() {
        return Convert::raw2xml(($this->MetaTitle) ? $this->MetaTitle : $this->Title);
    }

    public function getBodyClass() {
        return Utilities::sanitiseClassName($this->singular_name(),'-');
    }

    public function PropertySearchForm()
    {
        return new PropertySearchForm($this);
    }

    public function TradesmenSearchForm()
    {
        return new TradesmenSearchForm($this);
    }

    public function getLocationBreadcrumbs()
    {
        $request        =   $this->request;
        $breadcrumbs    =   array(array(
            'Title'     =>  'All properties',
            'URL'       =>  '/list'
        ));

        if ($region = $request->param('region')) {
            $item_region    =   array(
                                'Title'     =>  $region,
                                'URL'       =>  '/list/' . $region
                            );
            $breadcrumbs[] = $item_region;

            if ($district = $request->param('district')) {
                $item_city  =   array(
                                    'Title'     =>  $district,
                                    'URL'       =>  '/list/' . $region . '/' . $district
                                );
                $breadcrumbs[] = $item_city;

                if ($suburb = $request->param('suburb')) {
                    $item_sub   =   array(
                                        'Title'     =>  $suburb,
                                        'URL'       =>  '/list/' . $region . '/' . $district . '/' . $suburb
                                    );
                    $breadcrumbs[] = $item_sub;
                }
            }
        }

        unset($breadcrumbs[count($breadcrumbs) - 1]['URL']);
        // Debugger::inspect($breadcrumbs);
        $crumbs = array();
        foreach ($breadcrumbs as $breadcrumb)
        {
            $crumbs[] = new ArrayData($breadcrumb);
        }

        return new ArrayList($crumbs);
    }

}

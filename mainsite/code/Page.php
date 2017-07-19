<?php
use SaltedHerring\Debugger;
use SaltedHerring\Utilities as Utilities;
use SaltedHerring\SaltedPayment;
use SaltedHerring\SaltedPayment\API\Paystation;
class Page extends SiteTree
{

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

class Page_Controller extends ContentController
{

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

        parent::init();
        $themeDir = $this->ThemeDir();
        if (!$this->request->isAjax()) {
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

            Requirements::combine_files(
                'scripts.js',
                array(
                    "$themeDir/js/components/jquery/dist/jquery.min.js",
                    "$themeDir/js/components/datetimepicker/build/jquery.datetimepicker.full.min.js",
                    "$themeDir/js/components/gsap/src/minified/TweenMax.min.js",
                    "$themeDir/js/components/gsap/src/minified/easing/EasePack.min.js",
                    "$themeDir/js/components/cropperjs/dist/cropper.min.js",
                    "$themeDir/js/components/jquery.scrollTo/jquery.scrollTo.min.js",
                    "$themeDir/js/components/owl.carousel/docs/assets/owlcarousel/owl.carousel.min.js",
                    "$themeDir/js/components/salted-js/dist/salted-js.min.js",
                    "$themeDir/js/modules/formwork.js",
                    "$themeDir/js/modules/locationselect.js",
                    "$themeDir/js/modules/typesearch.js",
                    "$themeDir/js/modules/previewable.js",
                    "$themeDir/js/modules/rating.js",
                    "$themeDir/js/templates/interest_item.js",
                    "$themeDir/js/templates/interest_list.js",
                    "$themeDir/js/templates/rental_form.js",
                    "$themeDir/js/modules/property_action.js",
                    "$themeDir/js/templates/hb-member-testimonials.js",
                    "$themeDir/js/templates/hb-service-requesters.js",
                    "$themeDir/js/templates/hb-appointments.js",
                    "$themeDir/js/custom.scripts.js"
                )
            );
        }
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

    public function getPromoSeason()
    {
        return SiteConfig::current_site_config()->PromoSeason;
    }


    public function getLocationBreadcrumbs()
    {
        $url                =   ltrim($this->request->getVar('url'), '/');
        $segs               =   explode('/', $url);
        $first_seg          =   $segs[0];
        $first_seg          =   $first_seg == 'all-properties' ? 'list' : $first_seg;
        $base_title         =   $first_seg == 'list' ? 'All properties' : 'All business';

        $first_seg          =   '/' . $first_seg . '/';

        if ($this->ClassName == 'PropertyPage') {
            $region         =   $this->Region;
            $district       =   $this->City;
            $suburb         =   $this->Suburb;

            $region_url     =   $this->RegionSlug;
            $district_url   =   $this->CitySlug;
            $suburb_url     =   $this->SuburbSlug;

            $item_home      =   array(
                                    'Title'     =>  $base_title,
                                    'URL'       =>  $first_seg
                                );

            $item_region    =   new ArrayData(array(
                                    'Title'     =>  $region,
                                    'URL'       =>  $first_seg . $region_url
                                ));

            $item_city      =   new ArrayData(array(
                                    'Title'     =>  $district,
                                    'URL'       =>  $first_seg . $region_url . '/' . $district_url
                                ));

            $item_sub       =   new ArrayData(array(
                                    'Title'     =>  $suburb,
                                    'URL'       =>  $first_seg . $region_url . '/' . $district_url . '/' . $suburb_url
                                ));

            $item           =   new ArrayData(array(
                                    'Title'     =>  $this->Title,
                                ));

            return new ArrayList(array($item_home, $item_region, $item_city, $item_sub, $item));

        }

        $request        =   $this->request;
        $breadcrumbs    =   array(array(
            'Title'     =>  $base_title,
            'URL'       =>  $first_seg
        ));

        if ($region = $request->param('region')) {

            $item_region    =   array(
                                'Title'     =>  $region,
                                'URL'       =>  $first_seg . $region
                            );
            $breadcrumbs[] = $item_region;

            if ($district = $request->param('district')) {
                $item_city  =   array(
                                    'Title'     =>  $district,
                                    'URL'       =>  $first_seg . $region . '/' . $district
                                );
                $breadcrumbs[] = $item_city;

                if ($suburb = $request->param('suburb')) {
                    $item_sub   =   array(
                                        'Title'     =>  $suburb,
                                        'URL'       =>  $first_seg . $region . '/' . $district . '/' . $suburb
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

    public function getBackURL()
    {
        return $this->request->getVar('BackURL');
    }

    public function getHomepageHeroImage()
    {
        if ($this->ClassName != 'HomePage') {
            $home   =   HomePage::get()->first();
            return !empty($home->HomepageHeroID) ? $home->HomepageHero()->Cropped() : null;
        }

        return null;
    }

}

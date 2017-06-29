<?php
/**
 * An email sent to the user with a link to validate and activate their account.
 *
 * @package silverstripe-memberprofiles
 */
class VoucherGiverEmail extends Email
{

	public function __construct($voucher) {
		$from     =    Config::inst()->get('Email', 'noreply_email');
		$to       =    $voucher->Email;
		$subject  =    '[' . SiteConfig::current_site_config()->Title . '] We\'ve delivered your promo voucher';

		parent::__construct($from, $to, $subject);

		$this->setTemplate('VoucherGiverEmail');

		$this->populateTemplate(new ArrayData(
			 	array (
					'baseURL'      =>  Director::absoluteURL(Director::baseURL()),
                    'Voucher'      =>  $voucher->Serials,
                    'Link'         =>  Director::absoluteURL(Controller::join_links (
						Controller::join_links(Director::baseURL(), 'member', 'action'),
						"upgrade"
					))
				)
			 ));
	}
}

<?php
/**
 * @file ServicesAdmin.php
 *
 * */

class ServicesAdmin extends ModelAdmin {
	private static $managed_models = array('Service');
	private static $url_segment = 'services';
	private static $menu_title = 'Services';
	//private static $menu_icon = 'mainsite/images/category.png';

	public function getEditForm($id = null, $fields = null) {

		$form = parent::getEditForm($id, $fields);

		$grid = $form->Fields()->fieldByName($this->sanitiseClassName($this->modelClass));
		$grid->getConfig()
			->removeComponentsByType('GridFieldPaginator')
			->removeComponentsByType('GridFieldExportButton')
			->removeComponentsByType('GridFieldPrintButton')
			->addComponents(
				new GridFieldPaginatorWithShowAll(30)
			);
		return $form;
	}
}

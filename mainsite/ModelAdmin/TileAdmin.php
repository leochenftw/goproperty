<?php
/**
 * @file TileAdmin.php
 *
 * */

class TileAdmin extends ModelAdmin {
	private static $managed_models = array('Tile');
	private static $url_segment = 'tiles';
	private static $menu_title = 'Tiles';
	//private static $menu_icon = 'mainsite/images/category.png';

	public function getEditForm($id = null, $fields = null) {

		$form = parent::getEditForm($id, $fields);

		$grid = $form->Fields()->fieldByName($this->sanitiseClassName($this->modelClass));
		$grid->getConfig()
			->removeComponentsByType('GridFieldPaginator')
			->removeComponentsByType('GridFieldExportButton')
			->removeComponentsByType('GridFieldPrintButton')
			->addComponents(
				new GridFieldPaginatorWithShowAll(30),
                new GridFieldOrderableRows('SortOrder')
			);
		return $form;
	}
}

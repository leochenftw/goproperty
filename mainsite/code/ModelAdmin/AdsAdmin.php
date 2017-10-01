<?php
/**
 * @file AdsAdmin.php
 *
 * */

class AdsAdmin extends ModelAdmin {
    private static $managed_models = array('Ads');
    private static $url_segment = 'ads';
    private static $menu_title = 'Ads';
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

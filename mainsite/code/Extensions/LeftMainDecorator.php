<?php

class LeftMainDecorator extends LeftAndMainExtension
{
    public function onAfterInit()
    {
        CMSMenu::remove_menu_item('Help');
        CMSMenu::remove_menu_item('AdsAdmin');
    }
}

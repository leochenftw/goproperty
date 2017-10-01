<?php

use SaltedHerring\Debugger;

class SponsorController extends ContentController
{
    public function index()
    {
        $request                =   $this->request;
        if ($ID                 =   $request->param('ID')) {

            if ($ads            =   Ads::get()->byID($ID)) {
                $dest           =   $ads->LinkTo()->LinkURL;

                $ip             =   $_SERVER['REMOTE_ADDR'];
                $agent          =   $_SERVER['HTTP_USER_AGENT'];

                $click          =   new Click();
                $click->IP      =   $ip;
                $click->Agent   =   $agent;
                $click->AdsID   =   $ads->ID;
                $click->write();

                return $this->redirect($dest, 302);
            }
        }

        return $this->httpError(404);
    }
}

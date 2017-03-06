<?php

class ContactController extends Page_Controller
{
    /**
     * Defines methods that can be called directly
     * @var array
     */
    private static $allowed_actions = array(
        'ContactForm'
    );

    public function ContactForm()
    {
        return new ContactForm($this);
    }

}

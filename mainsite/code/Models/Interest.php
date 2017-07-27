<?php

class Interest extends DataObject
{
    private static $db = array(
        'Message'   =>  'Text',
        'hasRead'   =>  'Boolean',
        'Expired'   =>  'Boolean'
    );

    private static $has_one = array(
        'Member'    =>  'Member',
        'Business'  =>  'Business',
        'Property'  =>  'PropertyPage',
        'Listing'   =>  'Listing'
    );

    public function getData()
    {
        $member = $this->Member();
        $message = trim(strip_tags($this->Message));

        if (!empty($message)) {
            $message = str_replace("\n", '<br />', $message);
        } else {
            $message = '<em>No message</em>';
        }

        $data = array(
            'id'            =>  $this->ID,
            'property_id'   =>  $this->PropertyID,
            'token'         =>  Session::get('SecurityID'),
            'member'        =>  array(
                                    'id'        =>  $member->ID,
                                    'name'      =>  $member->getDisplayName(),
                                    'email'     =>  $member->Email,
                                    'portrait'  =>  !empty($member->Portrait()->ImageID) ? $member->Portrait()->Image()->Cropped()->FillMax(100, 100)->URL : '/themes/default/images/default-portrait.png',
                                    'rating'    =>  $member->getRating()->HTML
                                ),
            'message'       =>  $message,
            'fold'          =>  $this->hasRead
        );

        return $data;
    }
}

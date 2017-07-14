<?php

class Rating extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Stars'         =>  'Int',
        'Comment'       =>  'Text',
        'Key'           =>  'Varchar(40)',
        'TargetRole'    =>  'Varchar(16)'
    );

    private static $default_sort = array(
        'ID'            =>  'DESC'
    );

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Giver'         =>  'Member',
        'Taker'         =>  'Member',
        'Property'      =>  'PropertyPage',
        'NeoProp'       =>  'Property'
    );

    public function canCreate($member = null)
    {
        if (!empty(Member::currentUser())) {
            return true;
        }

        return false;
    }

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if ($this->Stars > 5) {
            $this->Stars = 5;
        }

        if ($this->Stars < 0) {
            $this->Stars = 0;
        }

        if (!$this->exists() && empty($this->GiverID)) {
            $this->GiverID = Member::currentUserID();
        }
    }

    public function getData()
    {
        $member                 =   $this->Giver();
        return  array(
                    'ID'        =>  $this->ID,
                    'Stars'     =>  $this->ratingHTML(),
                    'Comment'   =>  $this->Comment,
                    'Date'      =>  $this->Created,
                    'By'        =>  $member->getDisplayName(),
                    'portrait'  =>  !empty($member->Portrait()->ImageID) ? $member->Portrait()->Image()->Cropped()->FillMax(100, 100)->URL : '/themes/default/images/default-portrait.png',
                );
    }

    private function ratingHTML()
    {
        $arr = array();
        $n = $this->Stars;
        $i = floor($n);
        for ($j = 0; $j < 5; $j++) {
            $arr[] = '<li data-stars="' . ($j+1) . '" class="icon"><i class="fa fa-' . ($j < $i ? 'star' : 'star-o') . '"></i></li>';
        }

        if ($n == 0) {
            $arr[0] = '<li data-stars="1" class="icon"><i class="fa fa-star-o"></i></li>';
        } elseif ($n - $i > 0 ) {
            $arr[$i] = '<li data-stars="' . $i . '" class="icon"><i class="fa fa-star-half-o"></i></li>';
        }

        return implode("\n", $arr);
    }

}

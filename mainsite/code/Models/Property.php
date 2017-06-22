<?php

use SaltedHerring\Debugger;

class Property extends DataObject
{
    private $comments           =   array();

    private static $db = array(
        'Title'                 =>  'Varchar(2048)',
        'Content'               =>  'Text',
        'PropertyType'          =>  'Varchar(48)',
        'NumBedrooms'           =>  'Int',
        'NumBathrooms'          =>  'Int',
        'Amenities'             =>  'Text',
        'Furnishings'           =>  'Text',
        'Parking'               =>  'Varchar(64)',
        'SmokeAlarm'            =>  'Boolean',
        'Insulation'            =>  'Boolean',
        'MaxCapacity'           =>  'Int',
        'LandArea'              =>  'Int',
        'FloorArea'             =>  'Int'
    );

    private static $has_one = array(
        'Member'                =>  'Member'
    );

    private static $has_many = array(
        'Gallery'               =>  'Image',
        'Rentals'               =>  'Rental',
        'Ratings'               =>  'Rating'
    );

    private static $extensions  =   array(
        'AddressProperties'
    );

    public function getRating()
    {
        $data = array(
            'Rated'     =>  $this->Ratings()->filter(array('GiverID' => Member::currentUserID()))->first() ? true : false,
            'Count'     =>  0,
            'HTML'      =>  ''
        );

        $n = 0;

        if ($this->Ratings()->exists()) {
            $received = $this->Ratings()->where('"Rating"."Key" IS NULL')->distinct('"Rating"."ID"');
            $data['Count'] = $received->count();
            $total = $received->count() * 5;

            if ($total > 0) {
                $actual = 0;
                foreach ($received as $rating) {

                    $actual += $rating->Stars;
                    if (!$this->searchArray($rating->ID)) {
                        $comment_item = array(
                            'ID'        =>  $rating->ID,
                            'Member'    =>  $rating->Giver(),
                            'Comment'   =>  $rating->Comment,
                            'When'      =>  $rating->Created,
                            'Stars'     =>  $rating->Stars
                        );
                        $this->comments[] = $comment_item;
                    }
                }

                $n = ($actual / $total) * 5;
            }
        }

        $data['HTML'] = $this->ratingHTML($n);

        return new ArrayData($data);
    }

    public function searchArray($ID)
    {
        foreach ($this->comments as $comment)
        {
            if ($comment['ID'] == $ID) {
                return true;
            }
        }

        return false;
    }

    public function getComments()
    {
        return new ArrayList($this->comments);
    }

    private function ratingHTML($n)
    {
        $arr = array();
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

<?php use SaltedHerring\Debugger;

class Portrait extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Title'             =>  'Varchar(256)',
        'ContainerX'        =>  'Int',
        'ContainerY'        =>  'Int',
        'ContainerWidth'    =>  'Int',
        'ContainerHeight'   =>  'Int',
        'CropperX'          =>  'Int',
        'CropperY'		    =>  'Int',
        'CropperWidth'      =>  'Int',
        'CropperHeight'     =>  'Int'
    );
    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Image' =>  'Image'
    );

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (!empty($this->ImageID)) {
            $image = $this->Image();
            $image->ContainerX = $this->ContainerX;
            $image->ContainerY = $this->ContainerY;
            $image->ContainerWidth = $this->ContainerWidth;
            $image->ContainerHeight = $this->ContainerHeight;
            $image->CropperX = $this->CropperX;
            $image->CropperY = $this->CropperY;
            $image->CropperWidth = $this->CropperWidth;
            $image->CropperHeight = $this->CropperHeight;
            $image->write();
        }
    }
}

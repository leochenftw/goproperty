<?php use SaltedHerring\Debugger;

class Tile extends DataObject
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'SortOrder' =>  'Int',
        'Title'     =>  'Varchar'
    );

    /**
     * Default sort ordering
     * @var string
     */
    private static $default_sort = array(
        'SortOrder' =>  'ASC'
    );

    /**
     * Has_one relationship
     * @var array
     */
    private static $has_one = array(
        'Image'     =>  'Image',
        'LinkTo'    =>  'Link'
    );

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName('SortOrder');
        $fields->addFieldToTab('Root.Main', LinkField::create('LinkToID', 'Link to page or file'));
        return $fields;
    }

    /**
     * Event handler called before writing to the database.
     */
    public function onAfterWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->SortOrder)) {
            $this->SortOrder = $this->ID;
            $this->write();
        }
    }

    public function forTemplate()
    {
        return $this->renderWith('Tile');
    }
}

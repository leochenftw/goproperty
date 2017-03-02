<?php

class SlugExtension extends DataExtension
{
    /**
     * Database fields
     * @var array
     */
    private static $db = array(
        'Slug'      =>  'Varchar(256)'
    );

    public function updateCMSFields(FieldList $fields) {
        $field = $fields->fieldByName('Root.Main.Slug');
        $fields->replaceField('Slug', $field->performReadonlyTransformation());
    }

    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if ($this->owner->hasField('Title')) {
            $slug = $this->testSlug(SiteTree::create()->generateURLSegment($this->owner->Title));
            $this->owner->Slug = $slug;
        }
    }

    private function testSlug($slug)
    {
        $i = 0;
        $slugTrial = $slug;
        $class = $this->owner->ClassName;
        while ($class::get()->filter(array('Slug' => $slugTrial))->exclude(array('ID' => $this->owner->ID))->count() > 0)
        {
            $i++;
            $slugTrial = $slug . '-' . $i;
        }

        if ($i > 0) {
            $slug = $slug . '-' . $i;
        }

        return $slug;
    }
}

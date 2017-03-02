<?php
use SaltedHerring\Debugger;
class ServicesImporter extends BuildTask
{
	protected $title = 'Services importer';
	protected $description = 'Import services';

	protected $enabled = true;

	public function run($request)
    {
        foreach ($this->services as $service) {
            if (Service::get()->filter(array('Title' => $service))->count() == 0) {
                $serv = new Service();
                $serv->Title = $service;
                $serv->write();
            } else {
                print $service . 'exists!<br />';
            }
        }
    }

    private $services = array(
                            'Carpet cleaning',
                            'Window cleaning',
                            'Appliance repairs',
                            'Asbestos removals',
                            'Asphalt specialists',
                            'Bathroom specialists',
                            'Brick / Block layers',
                            'Builders',
                            'Cleaners',
                            'Concrete specialists',
                            'Curtains, drapes & blinds',
                            'Deck specialists',
                            'Demolition specialists',
                            'Doors specialists',
                            'Earthmovers',
                            'Electricians',
                            'Fencing & gates',
                            'Floor specialists',
                            'Furniture specialists',
                            'Furniture removals',
                            'Gardens & landscapes',
                            'Gas fitters & installers',
                            'Glaziers',
                            'Handymen',
                            'Heat pumps / aircon technicians',
                            'Insulation specialists',
                            'Lighting specialists',
                            'Locksmiths',
                            'Painters, plasterers & decorators',
                            'Paving',
                            'Pest controllers',
                            'Plumbers & drain layers',
                            'Refrigeration technicians',
                            'Roofing / Spouting',
                            'Scaffolding',
                            'Scrap metal',
                            'Security specialists',
                            'Solar energy',
                            'Stone Masons',
                            'Swimming pools & satellite',
                            'Waste disposal',
                            'Waterproofing'
                        );
}

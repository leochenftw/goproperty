<form $FormAttributes>
    <% if $Message %>
    <div id="PropertyForm_Message" class="notification is-<% if $MessageType == 'good' %>success<% else %>warning<% end_if %>"><button class="delete"></button>$Message</div>
    <% end_if %>
    <fieldset>
    <div class="fields columns is-marginless">
        <div class="fields__main column is-half is-paddingless">
            <div class="fields__main__section property-details">
                <div class="column is-12">
                    <h3 class="fields__main__section__title title is-4 is-bold">Property details</h3>
                </div>
                <div class="fields__main__section__content">
                    <div class="column is-12">
                        $Fields.fieldByName('PropertyType').FieldHolder
                        $Fields.fieldByName('Title').FieldHolder
                    </div>
                    <div class="columns is-marginless items-2 field-group">
                        $Fields.fieldByName('NumBedrooms').FieldHolder
                        $Fields.fieldByName('NumBathrooms').FieldHolder
                    </div>
                    <div class="columns is-marginless items-2 field-group">
                        $Fields.fieldByName('FloorArea').FieldHolder
                        $Fields.fieldByName('LandArea').FieldHolder
                    </div>
                    <div class="column is-12">
                        $Fields.fieldByName('Parking').FieldHolder
                        $Fields.fieldByName('Content').FieldHolder
                        <% loop $Fields %>
                            <% if $Name != 'ListTilGone' && $Name != 'PropertyType' && $Name != 'Title' && $Name != 'UnitNumber' && $Name != 'NumBedrooms' && $Name != 'NumBathrooms' && $Name != 'FloorArea' && $Name != 'LandArea' && $Name != 'Parking' && $Name != 'Content' && $Name != 'UnitNumber' && $Name != 'FullAddress' && $Name != 'Gallery' && $Name != 'ContactNumber' && $Name != 'ListerAgencyID' && $Name != 'AgencyReference' && $Name != 'RateableValue' && $Name != 'HideRV' && $Name != 'PriceOption' && $Name != 'AskingPrice' && $Name != 'EnquiriesOver' && $Name != 'AuctionOn' && $Name != 'TenderCloseOn' && $Name != 'PriceByNegotiation' && $Name != 'PrivateTreatyDeadline' && $Name != 'SmokeAlarm' && $Name != 'Insulation' && $Name != 'Amenities' && $Name != 'ListingCloseOn' %>
                                $FieldHolder
                            <% end_if %>
                        <% end_loop %>
                    </div>

                    <%--
                    'AskingPrice'           =>  'Asking price',
                    'EnquiriesOver'         =>  'Enquiries over',
                    'AuctionOn'             =>  'To be auctioned on',
                    'TenderCloseOn'         =>  'Tenders closing on',
                    'PriceByNegotiation'    =>  'Price by negotiation',
                    'PrivateTreatyDeadline' =>  'Deadline Private Treaty by'
                    --%>
                </div>
            </div>
            <div class="fields__main__section pricing">
                <div class="column is-12">
                    <h3 class="fields__main__section__title title is-4 is-bold">Price details</h3>
                </div>
                <div class="fields__main__section__content">
                    <div class="columns is-marginless items-2 field-group vertical-bottom space-between">
                        $Fields.fieldByName('RateableValue').addExtraClass('is-marginless').FieldHolder
                        $Fields.fieldByName('HideRV').addExtraClass('is-marginless').FieldHolder
                    </div>
                    <div class="column is-12">
                        $Fields.fieldByName('PriceOption').FieldHolder
                        $Fields.fieldByName('AskingPrice').FieldHolder
                        $Fields.fieldByName('EnquiriesOver').FieldHolder
                        $Fields.fieldByName('AuctionOn').FieldHolder
                        $Fields.fieldByName('TenderCloseOn').FieldHolder
                        $Fields.fieldByName('PriceByNegotiation').FieldHolder
                        $Fields.fieldByName('PrivateTreatyDeadline').FieldHolder
                    </div>
                </div>
            </div>
            <div class="fields__main__section contact column is-12">
                <h3 class="fields__main__section__title title is-4 is-bold">Contact details</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('ListerAgencyID').FieldHolder
                    $Fields.fieldByName('AgencyReference').FieldHolder
                    $Fields.fieldByName('ContactNumber').FieldHolder
                </div>
            </div>

            <div class="fields__main__section listing-options column is-12">
                <h3 class="fields__main__section__title title is-4 is-bold">Listing options</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('ListTilGone').FieldHolder
                </div>
            </div>

            <div class="fields__main__section listing column is-12">
                <h3 class="fields__main__section__title title is-4 is-bold">Listing length</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('ListingCloseOn').FieldHolder
                </div>
            </div>
        </div>
        <div class="fields__aside column is-half">
            <h3 class="title is-4 is-bold">Property on map</h3>
            $Fields.fieldByName('UnitNumber').FieldHolder
            $Fields.fieldByName('FullAddress').FieldHolder
            <div id="location-on-map"></div>
            <h3 class="title is-4 is-bold">Property photos</h3>
            $Fields.fieldByName('Gallery').FieldHolder
        </div>
    </div>
    </fieldset>
    <div class="Actions column is-12">
        <% if $AmountToPay %>
            <div class="content"><p>You are going to list this property for <strong>$Duration</strong> day<% if $Duration > 1 %>s<% end_if %>. This is going to cost you: <span>${$AmountToPay}</span></p></div>
        <% end_if %>
        <% if $ListFree %>
            <div class="content">
                <% if $ListTilGone %>
                    <p>You have paid for the listing until it gets sold. It means you may list and withdraw this particular propety without incurring additional charges before it's rented.</p>
                <% else %>
                    <p>You have paid for listing til the end of $ListUntil. It means before the duration has run out, you may list and withdraw this particular propety without incurring additional charges.</p>
                <% end_if %>
            </div>
        <% end_if %>
        $Actions
    </div>
</form>

<form $FormAttributes>
    <% if $Message %>
    <div id="PropertyForm_Message" class="message-wrapper $MessageType">$Message <button></button></div>
    <% end_if %>
    <fieldset>
    <div class="fields as-flex wrap">
        <div class="fields__main">
            <div class="fields__main__section property-details">
                <h3 class="fields__main__section__title">Property details</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('PropertyType').FieldHolder
                    $Fields.fieldByName('Title').FieldHolder
                    <div class="as-flex wrap items-2 field-group">
                        $Fields.fieldByName('NumBedrooms').FieldHolder
                        $Fields.fieldByName('NumBathrooms').FieldHolder
                    </div>
                    <div class="as-flex wrap items-2 field-group">
                        $Fields.fieldByName('FloorArea').FieldHolder
                        $Fields.fieldByName('LandArea').FieldHolder
                    </div>
                    $Fields.fieldByName('Parking').FieldHolder
                    $Fields.fieldByName('Content').FieldHolder

                    <% loop $Fields %>
                        <% if $Name != 'PropertyType' && $Name != 'Title' && $Name != 'UnitNumber' && $Name != 'NumBedrooms' && $Name != 'NumBathrooms' && $Name != 'FloorArea' && $Name != 'LandArea' && $Name != 'Parking' && $Name != 'Content' && $Name != 'UnitNumber' && $Name != 'FullAddress' && $Name != 'Gallery' && $Name != 'ContactNumber' && $Name != 'ListerAgencyID' && $Name != 'AgencyReference' && $Name != 'RateableValue' && $Name != 'HideRV' && $Name != 'PriceOption' && $Name != 'AskingPrice' && $Name != 'EnquiriesOver' && $Name != 'AuctionOn' && $Name != 'TenderCloseOn' && $Name != 'PriceByNegotiation' && $Name != 'PrivateTreatyDeadline' && $Name != 'SmokeAlarm' && $Name != 'Amenities' && $Name != 'ListingCloseOn' %>
                            $FieldHolder
                        <% end_if %>
                    <% end_loop %>

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
                <h3 class="fields__main__section__title">Price details</h3>
                <div class="fields__main__section__content">
                    <div class="as-flex wrap items-2 field-group vertical-bottom space-between">
                        $Fields.fieldByName('RateableValue').FieldHolder
                        $Fields.fieldByName('HideRV').FieldHolder
                    </div>
                    $Fields.fieldByName('PriceOption').FieldHolder
                    $Fields.fieldByName('AskingPrice').FieldHolder
                    $Fields.fieldByName('EnquiriesOver').FieldHolder
                    $Fields.fieldByName('AuctionOn').FieldHolder
                    $Fields.fieldByName('TenderCloseOn').FieldHolder
                    $Fields.fieldByName('PriceByNegotiation').FieldHolder
                    $Fields.fieldByName('PrivateTreatyDeadline').FieldHolder
                </div>
            </div>
            <div class="fields__main__section contact">
                <h3 class="fields__main__section__title">Contact details</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('ListerAgencyID').FieldHolder
                    $Fields.fieldByName('AgencyReference').FieldHolder
                    $Fields.fieldByName('ContactNumber').FieldHolder
                </div>
            </div>

            <div class="fields__main__section listing">
                <h3 class="fields__main__section__title">Listing length</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('ListingCloseOn').FieldHolder
                </div>
            </div>
        </div>
        <div class="fields__aside">
            <h3>Property on map</h3>
            $Fields.fieldByName('UnitNumber').FieldHolder
            $Fields.fieldByName('FullAddress').FieldHolder
            <div id="location-on-map"></div>
            <h3>Property photos</h3>
            $Fields.fieldByName('Gallery').FieldHolder
        </div>
    </div>
    </fieldset>
    <div class="Actions">
        <% if $AmountToPay %>
            <p>You are going to list this property for <strong>$Duration</strong> day<% if $Duration > 1 %>s<% end_if %>. This is going to cost you: <span>${$AmountToPay}</span></p>
        <% end_if %>
        <% if $ListFree %>
            <p>You have paid for listing til the end of $ListUntil. It means before the duration has run out, you may list and withdraw this particular propety without incurring additional charges.</p>
        <% end_if %>
        $Actions
    </div>
</form>

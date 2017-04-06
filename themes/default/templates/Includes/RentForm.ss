<form $FormAttributes>
    <% if $Message %>
    <div id="PropertyForm_Message" class="message-wrapper $MessageType">$Message <button></button></div>
    <% end_if %>
    <fieldset>
    <div class="fields as-flex wrap">
        <div class="fields__main">
            <div class="fields__main__section pricing">
                <h3 class="fields__main__section__title">Price details</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('WeeklyRent').FieldHolder
                </div>
            </div>
            <div class="fields__main__section property-details">
                <h3 class="fields__main__section__title">Property details</h3>
                <div class="fields__main__section__content">
                    <div class="as-flex wrap items-2 field-group">
                        $Fields.fieldByName('DateAvailable').FieldHolder
                        $Fields.fieldByName('PropertyType').FieldHolder
                    </div>
                    <div class="as-flex wrap items-2 field-group">
                        $Fields.fieldByName('IdealTenants').FieldHolder
                        $Fields.fieldByName('MaxCapacity').FieldHolder
                    </div>
                    <div class="as-flex wrap items-2 field-group">
                        $Fields.fieldByName('NumBedrooms').FieldHolder
                        $Fields.fieldByName('NumBathrooms').FieldHolder
                    </div>
                    <div class="as-flex wrap items-2 field-group">
                        $Fields.fieldByName('AllowPet').FieldHolder
                        $Fields.fieldByName('AllowSmoker').FieldHolder
                    </div>
                    $Fields.fieldByName('Content').FieldHolder
                    $Fields.fieldByName('Insulation').FieldHolder
                    <% loop $Fields %>
                        <% if $Name != 'ListTilGone' && $Name != 'Insulation' && $Name != 'Content' && $Name != 'ListingCloseOn' && $Name != 'IdealTenants' && $Name != 'AllowPet' && $Name != 'AllowSmoker' && $Name != 'NumBathrooms' && $Name != 'NumBedrooms' && $Name != 'MaxCapacity' && $Name != 'DateAvailable' && $Name != 'PropertyType' && $Name != 'UnitNumber' && $Name != 'FullAddress' && $Name != 'WeeklyRent' && $Name != 'Gallery' && $Name != 'ContactNumber' && $Name != 'ListerAgencyID' && $Name != 'AgencyReference'  %>
                            $FieldHolder
                        <% end_if %>
                    <% end_loop %>
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

            <div class="fields__main__section listing-options">
                <h3 class="fields__main__section__title">Listing options</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('ListTilGone').FieldHolder
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
            <div class="field uploader">
                <h3>Property photos</h3>
                $Fields.fieldByName('Gallery').FieldHolder
            </div>
        </div>
    </div>
    </fieldset>
    <div class="Actions">
        <% if $ListFree %>
            <p>You have paid for listing til the end of $ListUntil. It means before the duration has run out, you may list and withdraw this particular propety without incurring additional charges.</p>
        <% end_if %>
        $Actions
    </div>
</form>

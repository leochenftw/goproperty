<form $FormAttributes>
    <% if $Message %>
    <div id="PropertyForm_Message" class="notification is-<% if $MessageType == 'good' %>success<% else %>warning<% end_if %>"><button class="delete"></button>$Message</div>
    <% end_if %>
    <fieldset>
    <div class="fields columns is-marginless">
        <div class="fields__main column is-half is-paddingless">
            <div class="fields__main__section pricing column is-12">
                <h3 class="fields__main__section__title title is-4 is-bold">Price details</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('WeeklyRent').FieldHolder
                </div>
            </div>
            <div class="fields__main__section property-details">
                <div class="title-wrapper column is-12">
                    <h3 class="fields__main__section__title title is-4 is-bold">Property details</h3>
                </div>
                <div class="fields__main__section__content">
                    <div class="columns items-2 is-marginless field-group">
                        $Fields.fieldByName('DateAvailable').FieldHolder
                        $Fields.fieldByName('PropertyType').FieldHolder
                    </div>
                    <div class="columns items-2 is-marginless field-group">
                        $Fields.fieldByName('IdealTenants').FieldHolder
                        $Fields.fieldByName('MaxCapacity').FieldHolder
                    </div>
                    <div class="columns items-2 is-marginless field-group">
                        $Fields.fieldByName('NumBedrooms').FieldHolder
                        $Fields.fieldByName('NumBathrooms').FieldHolder
                    </div>
                    <div class="columns items-2 is-marginless field-group">
                        $Fields.fieldByName('AllowPet').FieldHolder
                        $Fields.fieldByName('AllowSmoker').FieldHolder
                    </div>
                    <div class="column is-12">
                        $Fields.fieldByName('Content').FieldHolder
                        $Fields.fieldByName('Insulation').FieldHolder
                        <% loop $Fields %>
                            <% if $Name != 'ListTilGone' && $Name != 'Insulation' && $Name != 'Content' && $Name != 'ListingCloseOn' && $Name != 'IdealTenants' && $Name != 'AllowPet' && $Name != 'AllowSmoker' && $Name != 'NumBathrooms' && $Name != 'NumBedrooms' && $Name != 'MaxCapacity' && $Name != 'DateAvailable' && $Name != 'PropertyType' && $Name != 'UnitNumber' && $Name != 'FullAddress' && $Name != 'WeeklyRent' && $Name != 'Gallery' && $Name != 'ContactNumber' && $Name != 'ListerAgencyID' && $Name != 'AgencyReference'  %>
                                $FieldHolder
                            <% end_if %>
                        <% end_loop %>
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
            <div class="field uploader">
                <h3 class="title is-4 is-bold">Property photos</h3>
                $Fields.fieldByName('Gallery').FieldHolder
            </div>
        </div>
    </div>
    </fieldset>
    <div class="Actions column is-12">
        <% if $ListFree %>
            <div class="content">
            <% if $ListTilGone %>
                <p>You have paid for the listing until it gets rented. It means you may list and withdraw this particular propety without incurring additional charges before it's rented.</p>
            <% else %>
                <p>You have paid for listing til the end of $ListUntil. It means before the duration has run out, you may list and withdraw this particular propety without incurring additional charges.</p>
            <% end_if %>
            </div>
        <% end_if %>
        $Actions
    </div>
</form>

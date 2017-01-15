<form $FormAttributes>
    <% if $Message %>
    <div class="message-wrapper error">$Message</div>
    <% end_if %>
    <div class="fields as-flex wrap">
        <div class="fields__main">
            <div class="fields__main__section property">
                <h3 class="fields__main__section__title">Property details</h3>
                <div class="fields__main__section__content">
                    <% loop $Fields %>
                        <% if $Name != 'FullAddress' && $Name != 'WeeklyRent' && $Name != 'Gallery' && $Name != 'ContactNumber' && $Name != 'ListerAgencyID' && $Name != 'AgencyReference'  %>
                            $FieldHolder
                        <% end_if %>
                    <% end_loop %>
                </div>
            </div>
            <div class="fields__main__section pricing">
                <h3 class="fields__main__section__title">Price details</h3>
                <div class="fields__main__section__content">
                    $Fields.fieldByName('WeeklyRent').FieldHolder
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
        </div>
        <div class="fields__aside">
            <h3>Property on map</h3>
            $Fields.fieldByName('FullAddress').FieldHolder
            <div id="location-on-map"></div>
            <h3>Property photos</h3>
            $Fields.fieldByName('Gallery').FieldHolder
        </div>
    </div>
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

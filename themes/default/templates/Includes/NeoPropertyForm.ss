<% if not $isAjax %><h2 class="title is-3 is-bold"><% if $isCreatingProperty %>Creating<% else %>Editing<% end_if %> property</h2><% end_if %>
<div class="content">
    <% with $CreatePropertyForm %>
        <form $FormAttributes>
            <%-- <progress class="progress is-success" value="$step" max="5"></progress> --%>
            <fieldset class="content">
                <legend class="title is-3">$FormTitle</legend>
                <% if $isAjax && $step ==5 %><% else %><p class="subtitle is-4">$FormSubtitle</p><% end_if %>
                <div class="fields">
                    <div class="show">
                        <% if $step == 0 %>
                            $Fields.fieldByName('FullAddress').FieldHolder
                            <div id="location-on-map"></div>
                            $Fields.fieldByName('Region').FieldHolder
                            $Fields.fieldByName('City').FieldHolder
                            $Fields.fieldByName('Suburb').FieldHolder
                        <% end_if %>
                        <% if $step == 1 %>
                        $Fields.fieldByName('PropertyType').FieldHolder
                        $Fields.fieldByName('UnitNumber').FieldHolder
                        <% end_if %>
                        <% if $step == 2 %>
                        $Fields.fieldByName('NumBedrooms').FieldHolder
                        $Fields.fieldByName('NumBathrooms').FieldHolder
                        $Fields.fieldByName('MaxCapacity').FieldHolder
                        $Fields.fieldByName('Parking').FieldHolder
                        $Fields.fieldByName('SmokeAlarm').FieldHolder
                        $Fields.fieldByName('Insulation').FieldHolder
                        <% end_if %>
                        <% if $step == 3 %>
                        $Fields.fieldByName('Gallery').FieldHolder
                        <% end_if %>
                        <% if $step == 4 %>
                        $Fields.fieldByName('Content').FieldHolder
                        $Fields.fieldByName('Amenities').FieldHolder
                        <% end_if %>
                        <% if $step == 5 %>
                        <% with $property %>
                        <div class="mini-property-overview">
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Address</h4></div>
                                <div class="column">$FullAddress <a href="/member/action/manage-property?id=$ID&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Property type</h4></div>
                                <div class="column">$PropertyType <a href="/member/action/manage-property?id=$ID&step=1&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Unit/Flat/Level</h4></div>
                                <div class="column">$UnitNumber <a href="/member/action/manage-property?id=$ID&step=1&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Bedrooms</h4></div>
                                <div class="column">$NumBedrooms bedroom<% if $NumBedrooms > 1 %>s<% end_if %> <a href="/member/action/manage-property?id=$ID&step=2&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Bathrooms</h4></div>
                                <div class="column">$NumBathrooms bathroom<% if $NumBathrooms > 1 %>s<% end_if %> <a href="/member/action/manage-property?id=$ID&step=2&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Capacity</h4></div>
                                <div class="column">Up to $MaxCapacity <% if $MaxCapacity > 1 %>people<% else %>person<% end_if %> can live in this property <a href="/member/action/manage-property?id=$ID&step=2&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Parking</h4></div>
                                <div class="column">$Parking <a href="/member/action/manage-property?id=$ID&step=2&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Smoke alarm</h4></div>
                                <div class="column"><% if $SmokeAlarm %>Yes<% else %>No<% end_if %> <a href="/member/action/manage-property?id=$ID&step=2&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Insulation</h4></div>
                                <div class="column"><% if $Insulation %>Yes<% else %>No<% end_if %> <a href="/member/action/manage-property?id=$ID&step=2&editing=1">Change</a></div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Photos</h4></div>
                                <div class="column">
                                    <div class="photos-row">
                                        <% loop $Gallery %>
                                        <a href="$URL" target="_blank" data-lightbox="$Up.Title">$FillMax(100, 100)</a>
                                        <% end_loop %>
                                    </div>
                                    <div class="link-row"><a href="/member/action/manage-property?id=$ID&step=3&editing=1">Add more</a></div>
                                </div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Details</h4></div>
                                <div class="column">
                                    $Content
                                    <p class="link-row"><a href="/member/action/manage-property?id=$ID&step=4&editing=1">Change</a></p>
                                </div>
                            </div>
                            <div class="columns">
                                <div class="column is-3"><h4 class="title is-5 is-marginless">Amenities</h4></div>
                                <div class="column">
                                    $Amenities
                                    <p class="link-row"><a href="/member/action/manage-property?id=$ID&step=4&editing=1">Change</a></p>
                                </div>
                            </div>
                        </div>
                        <% end_with %>
                        <% end_if %>
                    </div>
                    <div class="hide">
                        $Fields.fieldByName('StreetNumber').FieldHolder
                        $Fields.fieldByName('StreetName').FieldHolder
                        $Fields.fieldByName('Country').FieldHolder
                        $Fields.fieldByName('PostCode').FieldHolder
                        $Fields.fieldByName('Lat').FieldHolder
                        $Fields.fieldByName('Lng').FieldHolder
                        $Fields.fieldByName('ExistingGallery').FieldHolder
                        $Fields.fieldByName('toDelete').FieldHolder
                        $Fields.fieldByName('Editing').FieldHolder
                    </div>
                </div>
            </fieldset>
            <div class="Actions">
                $Fields.fieldByName('SecurityID').FieldHolder
                <nav class="pagination<% if $isAjax %> is-centered<% end_if %>">
                    <% if not $isAjax %>
                        $Actions.First
                        $Actions.Last
                    <% else %>
                        <a href="#" class="do-cancel pagination-previous">Cancel</a>
                        $Actions.Last.addExtraClass('inline')
                        <ul class="pagination-list" style="list-style: none; margin: 0;">
                        <% loop $Nav %>
                            <li style="margin-top: 0;"><a href="$URL" class="pagination-link<% if $Pos == $Step %> is-current<% end_if %>" title="$Title">$HTML</a></li>
                        <% end_loop %>
                        </ul>
                    <% end_if %>
                </nav>
            </div>
        </form>
    <% end_with %>
</div>

<div class="search-forms">
    <div class="container">
    <label for="searchNav" class="is-hidden-tablet button">Menu</label>
    <input id="searchNav" type="checkbox" class="hide">
        <div class="columns has-text-centered fake-tabs" id="PropertySearchNav">
            <a data-description="Rental Property" class="column is-2 tab-ish search-tab active" href="#PropertySearchForm_PropertySearchForm" data-show="for-rent" data-hide="for-sale">Find a <span>Rental Property</span></a>
            <a data-description="Property for Sale" class="column is-2 tab-ish search-tab" href="#PropertySearchForm_PropertySearchForm" data-show="for-sale" data-hide="for-rent">Properties <span>For Sale</span></a>
            <a data-description="Tradesperson" class="column is-2 tab-ish search-tab" href="#TradesmenSearchForm_TradesmenSearchForm">Find a <span>Tradesperson</span></a>
            <%-- <a class="column is-2 tab-ish" href="/member/action/list-property-for-rent">List a <span>property</span></a> --%>
            <a class="column is-2 tab-ish" href="/resources"><span>Resources</span></a>
        </div>
        <% if $Top.TopAds %>
            $Top.TopAds
        <% end_if %>
        <% with $PropertySearchForm %>
        <form $FormAttributes>
            <h2 class="form-title title is-2">Search</h2>

            <div id="form-description" class="form-description">Search for a <span>Rental Property</span></div>
            <div class="columns Fields">
                <div class="column is-half left-half half" id="div-left">
                    <div class="fields-wrapper columns location">
                        <label class="label is-3 column">Region</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('Region')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns location">
                        <label class="label is-3 column">Location</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('City')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns location">
                        <label class="label is-3 column">Suburb</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('Suburb')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns type for-rent">
                        <label class="label is-3 column">Property type</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('RentalPropertyType')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns type for-sale hide">
                        <label class="label is-3 column">Property type</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('SalePropertyType')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns bedroom">
                        <label class="label is-3 column">Bedrooms</label>
                        <div class="fields column columns is-marginless columns-2">
                            <div class="field is-paddingless column">$Fields.fieldByName('BedroomFrom')</div>
                            <span class="column is-auto-width" id="padding-b-0">To</span>
                            <div class="field is-paddingless column">$Fields.fieldByName('BedroomTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns bathroom">
                        <label class="label is-3 column">Bathrooms</label>
                        <div class="fields column columns is-marginless  columns-2">
                            <div class="field is-paddingless column">$Fields.fieldByName('BathroomFrom')</div>
                            <span class="column is-auto-width" id="padding-b-0">To</span>
                            <div class="field is-paddingless column">$Fields.fieldByName('BathroomTo')</div>
                        </div>
                    </div>
                </div>
                <div class="column is-half right-half half" id="div-right">
                    <div class="fields-wrapper columns price for-rent">
                        <label class="label is-3 column">Rent range</label>
                        <div class="fields column columns is-marginless columns-2">
                            <div class="field is-paddingless column">$Fields.fieldByName('RentFrom')</div>
                            <span class="column is-auto-width" id="padding-b-0">To</span>
                            <div class="field is-paddingless column">$Fields.fieldByName('RentTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns price for-sale hide">
                        <label class="label is-3 column">Price range</label>
                        <div class="fields column columns is-marginless columns-2 ">
                            <div class="field is-paddingless column">$Fields.fieldByName('PriceFrom')</div>
                            <span class="column is-auto-width" id="padding-b-0">To</span>
                            <div class="field is-paddingless column">$Fields.fieldByName('PriceTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns availability for-rent">
                        <label class="label is-3 column">Available from</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('Availability')</div>
                        </div>
                    </div>
                    <div class="for-rent">
                        <div id="AllowPet" class="fields-wrapper columns pet-ok for-rent optionset">
                            <label class="label is-3 column">Pet OK</label>
                            <div class="fields column">
                                <div class="field">$Fields.fieldByName('AllowPet')</div>
                            </div>
                        </div>
                        <div id="AllowSmoker" class="fields-wrapper columns smoker-ok for-rent optionset">
                            <label class="label is-3 column">Smoker OK</label>
                            <div class="fields column">
                                <div class="field">$Fields.fieldByName('AllowSmoker')</div>
                            </div>
                        </div>
                    </div>
                    $Fields.fieldByName('SecurityID').FieldHolder
                    <div class="actions">
                        <div class="hide">
                            $Fields.fieldByName('RentOrSale').FieldHolder
                        </div>
                        $Actions
                    </div>
                </div>
            </div>
            <% if $Top.RentalFormTitle || $Top.RentalFormContent %>
            <div class="form-description for-rent">
                <% if $Top.RentalFormTitle %><div style="color: #5e5e5e; margin-bottom: 25px;">$Top.RentalFormTitle</div><% end_if %>
                <% if $Top.RentalFormContent %>
                <div class="has-2-column content">
                    $Top.RentalFormContent
                </div>
                <% end_if %>
            </div>
            <% end_if %>
            <% if $Top.SaleFormTitle || $Top.SaleFormContent %>
            <div class="form-description for-sale hide">
                <% if $Top.SaleFormTitle %><div style="color: #5e5e5e; margin-bottom: 25px;">$Top.SaleFormTitle</div><% end_if %>
                <% if $Top.SaleFormContent %>
                <div class="has-2-column content">
                    $Top.SaleFormContent
                </div>
                <% end_if %>
            </div>
            <% end_if %>
        </form>
        <% end_with %>
        <% with $TradesmenSearchForm %>
        <form $FormAttributes>
            <h2 class="form-title title is-2">Search</h2>
            <div id="form-description" class="form-description">Search for a Rental Property</div>
            <div class="columns Fields">
                <div class="column is-half left-half half">
                    <div class="fields-wrapper columns location">
                        <label class="label column is-3">Location</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('Region')</div>
                            <div class="field">$Fields.fieldByName('City')</div>
                            <div class="field">$Fields.fieldByName('Suburb')</div>
                        </div>
                    </div>
                </div>
                <div class="column is-half right-half half">
                    <div class="fields-wrapper columns work-type">
                        <label class="label column is-3">Work type</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('WorkType')</div>
                        </div>
                    </div>
                    $Fields.fieldByName('SecurityID').FieldHolder
                    <div class="actions">
                        <div class="hide">
                            $Fields.fieldByName('RentOrSale').FieldHolder
                        </div>
                        $Actions
                    </div>
                </div>
            </div>
            <% if $Top.TradesFormTitle || $Top.TradesFormContent %>
            <div class="form-description">
                <% if $Top.TradesFormTitle %><div style="color: #5e5e5e; margin-bottom: 25px;">$Top.TradesFormTitle</div><% end_if %>
                <% if $Top.TradesFormContent %>
                <div class="has-2-column content">
                    $Top.TradesFormContent
                </div>
                <% end_if %>
            </div>
            <% end_if %>
        </form>
        <% end_with %>
    </div>
</div>

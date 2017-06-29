<div class="search-forms">
    <div class="container">
        <div class="columns has-text-centered fake-tabs">
            <a data-description="Rental Property" class="column is-2 tab-ish search-tab active" href="#PropertySearchForm_PropertySearchForm" data-show="for-rent" data-hide="for-sale">Find a <span>Rental Property</span></a>
            <a data-description="Property for Sale" class="column is-2 tab-ish search-tab" href="#PropertySearchForm_PropertySearchForm" data-show="for-sale" data-hide="for-rent">Properties <span>For Sale</span></a>
            <a data-description="Tradesperson" class="column is-2 tab-ish search-tab" href="#TradesmenSearchForm_TradesmenSearchForm">Find a <span>Tradesperson</span></a>
            <%-- <a class="column is-2 tab-ish" href="/member/action/list-property-for-rent">List a <span>property</span></a> --%>
            <a class="column is-2 tab-ish" href="/resources"><span>Resources</span></a>
        </div>
        <% with $PropertySearchForm %>
        <form $FormAttributes>
            <h2 class="form-title title is-2">Search</h2>
            <div id="form-description" class="form-description">Search for a <span>Rental Property</span></div>
            <div class="columns Fields">
                <div class="column is-half left-half half">
                    <div class="fields-wrapper columns location">
                        <label class="label is-3 column">Location</label>
                        <div class="fields column">
                            <div class="field">$Fields.fieldByName('Region')</div>
                            <div class="field">$Fields.fieldByName('City')</div>
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
                        <div class="fields column columns is-marginless">
                            <div class="field is-paddingless column">$Fields.fieldByName('BedroomFrom')</div>
                            <span class="column is-auto-width">To</span>
                            <div class="field is-paddingless column">$Fields.fieldByName('BedroomTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns bathroom">
                        <label class="label is-3 column">Bathrooms</label>
                        <div class="fields column columns is-marginless">
                            <div class="field is-paddingless column">$Fields.fieldByName('BathroomFrom')</div>
                            <span class="column is-auto-width">To</span>
                            <div class="field is-paddingless column">$Fields.fieldByName('BathroomTo')</div>
                        </div>
                    </div>
                </div>
                <div class="column is-half right-half half">
                    <div class="fields-wrapper columns price for-rent">
                        <label class="label is-3 column">Rent range</label>
                        <div class="fields column columns is-marginless">
                            <div class="field is-paddingless column">$Fields.fieldByName('RentFrom')</div>
                            <span class="column is-auto-width">To</span>
                            <div class="field is-paddingless column">$Fields.fieldByName('RentTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper columns price for-sale hide">
                        <label class="label is-3 column">Price range</label>
                        <div class="fields column columns is-marginless">
                            <div class="field is-paddingless column">$Fields.fieldByName('PriceFrom')</div>
                            <span class="column is-auto-width">To</span>
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
        </form>
        <% end_with %>
    </div>
</div>

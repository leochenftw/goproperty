<div class="search-forms">
    <div class="container">
        <div class="as-flex horizontal-centred fake-tabs">
            <a class="tab-ish search-tab active" href="#PropertySearchForm_PropertySearchForm" data-show="for-rent" data-hide="for-sale">Find a <span>Rental Property</span></a>
            <a class="tab-ish search-tab" href="#PropertySearchForm_PropertySearchForm" data-show="for-sale" data-hide="for-rent">Properties <span>For Sale</span></a>
            <a class="tab-ish search-tab" href="#TradesmenSearchForm_TradesmenSearchForm">Find a <span>Tradesperson</span></a>
            <a class="tab-ish" href="/member/action/list-property-for-rent">List a <span>property</span></a>
            <a class="tab-ish" href="/resources"><span>Resources</span></a>
        </div>
        <% with $PropertySearchForm %>
        <form $FormAttributes>
            <h2 class="form-title">Search</h2>
            <div id="form-description" class="form-description">Search for a Rental Property</div>
            <div class="as-flex wrap Fields">
                <div class="left-half half">
                    <div class="fields-wrapper location">
                        <label class="label">Location</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('Region')</div>
                            <div class="field">$Fields.fieldByName('City')</div>
                            <div class="field">$Fields.fieldByName('Suburb')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper type for-rent">
                        <label class="label">Property type</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('RentalPropertyType')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper type for-sale hide">
                        <label class="label">Property type</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('SalePropertyType')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper bedroom">
                        <label class="label">Bedrooms</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('BedroomFrom')</div>
                            <span>To</span>
                            <div class="field">$Fields.fieldByName('BedroomTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper bathroom">
                        <label class="label">Bathrooms</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('BathroomFrom')</div>
                            <span>To</span>
                            <div class="field">$Fields.fieldByName('BathroomTo')</div>
                        </div>
                    </div>
                </div>
                <div class="right-half half">
                    <div class="fields-wrapper price for-rent">
                        <label class="label">Rent range</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('RentFrom')</div>
                            <span>To</span>
                            <div class="field">$Fields.fieldByName('RentTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper price for-sale hide">
                        <label class="label">Price range</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('PriceFrom')</div>
                            <span>To</span>
                            <div class="field">$Fields.fieldByName('PriceTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper availability for-rent">
                        <label class="label">Available from</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('Availability')</div>
                        </div>
                    </div>
                    <div class="for-rent">
                        $Fields.fieldByName('AllowPet').FieldHolder
                        $Fields.fieldByName('AllowSmoker').FieldHolder
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
            <h2 class="form-title">Search</h2>
            <div id="form-description" class="form-description">Search for a Rental Property</div>
            <div class="as-flex wrap Fields">
                <div class="left-half half">
                    <div class="fields-wrapper location">
                        <label class="label">Location</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('Region')</div>
                            <div class="field">$Fields.fieldByName('City')</div>
                            <div class="field">$Fields.fieldByName('Suburb')</div>
                        </div>
                    </div>
                </div>
                <div class="right-half half">
                    <div class="fields-wrapper work-type">
                        <label class="label">Work type</label>
                        <div class="fields">
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

<section class="hero hero-region" style="background-image: url($HomepageHeroImage.SetWidth(1980).URL);">
    <div class="hero-body">
        <div class="container">
            <%-- <header><h1 class="hero-region__logo-full">$Title</h1></header> --%>
            <header><h1 class="hide">$Title</h1></header>
        </div>
    </div>
</section>
<section class="section">
    <div class="container has-text-centered">
        <h1 class="title is-1 is-bold is-jumbo">$Title</h1>
        <div class="content">
            $Content
        </div>
        <div class="search-forms hide is-paddingless">
        <% with $PropertySearchForm %>
            <form $FormAttributes>
                <h2 class="title is-1 is-bold">Rekey in your search terms</h2>
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
        </div>
    </div>
</section>

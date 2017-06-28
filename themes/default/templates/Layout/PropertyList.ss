<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<section class="section property-list">
    <div class="container">
        <header class="columns is-12 vertical-centred">
            <div class="column"><h1 class="title is-2 is-marginless">Search result</h1></div>
            <div class="column is-auto-width"><a href="#" class="button inline show-search-form">Refine the result</a></div>
        </header>
        <div class="search-forms hide is-paddingless">
        <% with $PropertySearchForm %>
            <form $FormAttributes>
                <div id="form-description" class="form-description">Refining your search result</div>
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
        <div class="criteria">
            <h2 class="column is-12">Search criteria:</h2>
            $FilterForm
        </div>
        <% if $Properties.Count > 0 %>
            <div class="columns tiles is-marginless">
                <% loop $Properties %>
                    <% include PropertyTile %>
                <% end_loop %>
            </div>
            <div class="container pagination text-center">

                <% if $Properties.MoreThanOnePage %>
                    <% if $Properties.NotFirstPage %>
                        <a class="prev" href="$Properties.PrevLink">‹</a>
                    <% end_if %>
                    <% loop $Properties.Pages %>
                        <% if $CurrentBool %>
                            <span>$PageNum</span>
                        <% else %>
                            <% if $Link %>
                                <a href="$Link">$PageNum</a>
                            <% else %>
                                ...
                            <% end_if %>
                        <% end_if %>
                        <% end_loop %>
                    <% if $Properties.NotLastPage %>
                        <a class="next" href="$Properties.NextLink">›</a>
                    <% end_if %>
                <% end_if %>
            </div>
        <% else %>
            <div class="column is-12 content"  style="margin: 40px 0 80px;">
                <p class="title is-4">Unfortunately your search criteria didn’t produce any results please change your criteria, or try <a style="border-bottom: 1px solid #001d58;" href="#" class="show-search-form">refining the result</a>.</p>
            </div>
        <% end_if %>
    </div>
</div>
<% include MidPageBanner Label='To list a Property, Rental or as a Tradesperson' %>

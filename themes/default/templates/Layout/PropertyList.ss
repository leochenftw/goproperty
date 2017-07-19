<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<section class="section property-list">
    <div class="container">
        <nav class="breadcrumb">
        <% loop $LocationBreadcrumbs %>
            <% if $URL %>
            <a href="$URL" class="breadcrumb-item">$Title</a>
            <% else %>
                <span class="breadcrumb-item is-active">$Title</span>
            <% end_if %>
        <% end_loop %>
        </nav>

        <header class="columns is-12 vertical-centred is-marginless">
            <div class="column"><h1 class="title is-2 is-marginless">Search result</h1></div>
            <div class="column is-auto-width"><a href="#" class="button inline show-search-form">Refine the result</a></div>
        </header>

        <div class="search-forms hide is-paddingless">
        <% with $PropertySearchForm %>
            <form $FormAttributes>
                <div id="form-description" class="form-description columns">
                    <div class="column">Refining your search result</div>
                    <div class="column is-narrow">
                        <div class="component-switch-board" data-left="#PropertySearchForm_PropertySearchForm_RentOrSale_rent" data-right="#PropertySearchForm_PropertySearchForm_RentOrSale_sale">
                            <span class="switch-label" data-lr="left">Rent</span>
                            <div class="switch-board at-left">
                                <span class="switch"></span>
                            </div>
                            <span class="switch-label" data-lr="right">Sale</span>
                        </div>
                        <div class="hide">
                            $Fields.fieldByName('RentOrSale').FieldHolder
                        </div>
                    </div>
                </div>
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
                            $Actions
                        </div>
                    </div>
                </div>
            </form>
        <% end_with %>
        </div>
        <div class="criteria">
            <h2 class="column is-12 is-paddingless-vertical">Search criteria:</h2>
            $FilterForm
        </div>
        <% if $Properties.Count > 0 %>
            <div class="columns tiles is-marginless">
                <% loop $Properties %>
                    <% include PropertyTile %>
                <% end_loop %>
            </div>
            <% if $Properties.MoreThanOnePage %>
            <nav class="pagination">
                <a href="$Properties.PrevLink" class="pagination-previous"<% if not $Properties.NotFirstPage %> disabled<% end_if %>>Prev</a>
                <a href="$Properties.NextLink" class="pagination-next"<% if not $Properties.NotLastPage %> disabled<% end_if %>>Next</a>
                <ul class="pagination-list" style="list-style: none; margin: 0;">
                <% loop $Properties.Pages %>
                    <% if $Link %>
                        <li style="margin-top: 0;"><a href="$Link" class="pagination-link<% if $CurrentBool %> is-current<% end_if %>">$PageNum</a></li>
                    <% else %>
                        ...
                    <% end_if %>
                <% end_loop %>
                </ul>
            </nav>
            <% end_if %>
        <% else %>
            <div class="column is-12 content"  style="margin: 40px 0 80px;">
                <p class="title is-4">Unfortunately your search criteria didn’t produce any results please change your criteria, or try <a style="border-bottom: 1px solid #001d58;" href="#" class="show-search-form">refining the result</a>.</p>
            </div>
        <% end_if %>
    </div>
</div>
<% include MidPageBanner Label='To list a Property, Rental or as a Tradesperson' %>

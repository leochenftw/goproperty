<div class="hero-region" style="background-image: url($HomepageHero.SetWidth(1980).URL);">
    <h1 class="hero-region__logo-full">$Title</h1>
</div>
<div class="search-forms">

    <div class="container">
        <% with $Form %>
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
                    <div class="fields-wrapper type">
                        <label class="label">Property type</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('PropertyType')</div>
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
                    <div class="fields-wrapper price">
                        <label class="label">Rent range</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('RentFrom')</div>
                            <span>To</span>
                            <div class="field">$Fields.fieldByName('RentTo')</div>
                        </div>
                    </div>
                    <div class="fields-wrapper availability">
                        <label class="label">Available from</label>
                        <div class="fields">
                            <div class="field">$Fields.fieldByName('Availability')</div>
                        </div>
                    </div>
                    $Fields.fieldByName('AllowPet').FieldHolder
                    $Fields.fieldByName('AllowSmoker').FieldHolder
                    $Fields.fieldByName('SecurityID').FieldHolder
                    <div class="actions">
                        $Actions
                    </div>
                </div>
            </div>
        </form>
        <% end_with %>
    </div>
</div>
<% include MidPageBanner Label='To list a Property, Rental or as a Tradesperson' %>
<section class="section tiles">
    <div class="container">
        <header><h2 class="tiles__title">Browse listings</h2></header>
        <div class="tiles__tiles as-flex wrap space-between">
            <% include HomeTiles %>
        </div>
    </div>
</section>

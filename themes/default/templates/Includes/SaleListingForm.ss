<div class="ajax-content">
    <div class="columns is-marginless vertical-bottom">
        <div class="column is-paddingless"><h4 class="title">Create new sale listing</h4></div>
    </div>
<% with $SaleListingForm %>
    <form $FormAttributes>
        <fieldset>
            $Fields.fieldByName('ListingID').FieldHolder
            $Fields.fieldByName('AgencyID').FieldHolder
            $Fields.fieldByName('AgencyReference').FieldHolder
            $Fields.fieldByName('ContactNumber').FieldHolder
            <div class="columns">
                <div class="column">
                    $Fields.fieldByName('FloorArea').FieldHolder
                </div>
                <div class="column">
                    $Fields.fieldByName('LandArea').FieldHolder
                </div>
            </div>
            <div class="columns">
                <div class="column">
                    $Fields.fieldByName('RateableValue').FieldHolder
                    $Fields.fieldByName('HideRV').FieldHolder
                </div>
                <div class="column">
                    $Fields.fieldByName('ExpectdSalePrice').FieldHolder
                </div>
            </div>
            <div class="columns">
                <div class="column is-half">
                    $Fields.fieldByName('PriceOption').FieldHolder
                </div>
            </div>
            <div class="hide price-options">
                $Fields.fieldByName('AskingPrice')
                $Fields.fieldByName('EnquiriesOver')
                $Fields.fieldByName('AuctionOn')
                $Fields.fieldByName('TenderCloseOn')
                $Fields.fieldByName('PrivateTreatyDeadline')
            </div>
            <div class="columns">
                <div class="column is-4">
                    $Fields.fieldByName('OpenHomeFrequency').FieldHolder
                </div>
                <div class="column">
                    $Fields.fieldByName('OpenHomeDays').FieldHolder
                    $Fields.fieldByName('OpenHomeTimes').FieldHolder
                </div>
            </div>
            $Fields.fieldByName('ListTilGone').FieldHolder
            $Fields.fieldByName('DisplayListTil').FieldHolder
            $Fields.fieldByName('ListTilDate').FieldHolder
            $Fields.fieldByName('PropertyID').FieldHolder
            $Fields.fieldByName('SecurityID').FieldHolder
        </fieldset>
        <div class="Actions">
            <nav class="pagination is-centered">
                <% if $Actions.Count == 1 %>
                <a href="#" class="pagination-previous do-cancel">Cancel</a>
                <% end_if %>
                $Actions
            </nav>
        </div>
    </form>
<% end_with %>
</div>

<% include SearchForms %>
<%-- <% if $Content %>
<section class="section is-paddingless-top content-area">
    <div class="container">
        <div class="has-2-column content">
            $Content
        </div>
    </div>
</section>
<% end_if %> --%>
<% include MidPageBanner Label='To list a Property, Rental or as a Tradesperson' %>
<section class="section tiles">
    <div class="container">
        <header class="column is-12"><h2 class="tiles__title title is-2">Browse listings</h2></header>
        <div class="tiles__tiles columns is-marginless">
            <% if $MidAds %>
                $MidAds
            <% end_if %>
            <% include HomeTiles %>
            <% if $BottomAds %>
                $BottomAds
            <% end_if %>
        </div>
    </div>
</section>

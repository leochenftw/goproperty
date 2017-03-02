<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<section class="section property-list">
    <header class="container padding"><h1>Search result</h1></header>
    <div class="container criteria padding">
        <h2>Search criteria:</h2>
    </div>
    <div class="container as-flex wrap tiles">
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
</div>
<% include MidPageBanner Label='To list a Property, Rental or as a Tradesperson' %>

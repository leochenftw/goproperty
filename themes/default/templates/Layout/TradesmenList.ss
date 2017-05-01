<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<section class="section property-list">
    <div class="container">
        <header class="column is-12">
            <h1 class="title is-2">Search result</h1>
            <div class="subtitle is-5 criteria padding">
                <h2>Search criteria:</h2>
            </div>
        </header>
        <div class="columns tiles is-marginless">
            <% loop $Business %>
                <% include BusinessTile %>
            <% end_loop %>
        </div>
        <div class="pagination text-center">

            <% if $Business.MoreThanOnePage %>
                <% if $Business.NotFirstPage %>
                    <a class="prev" href="$Business.PrevLink">‹</a>
                <% end_if %>
                <% loop $Business.Pages %>
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
                <% if $Business.NotLastPage %>
                    <a class="next" href="$Business.NextLink">›</a>
                <% end_if %>
            <% end_if %>
        </div>
    </div>
</div>
<% include MidPageBanner Label='To list a Property, Rental or as a Tradesperson' %>

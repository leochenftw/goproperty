<div class="tradesmen-list__tile">
    <a href="$Link" class="tradesmen-list__tile__cover business-logo">
        <% if $Logo %>$Logo.FillMax(580, 338)<% else %>https://placehold.it/580x338<% end_if %>
    </a>
    <div class="tradesmen-list__tile__details as-flex wrap space-between relative">
        <div class="tradesmen-list__tile__details__price business-detail">
            <% if $Title %><h2>$Title</h2><% end_if %>
            <% if $FullAddress %><div class="iconed icon-property">$FullAddress</div><% end_if %>
            <% if $ContactNumber %><div class="iconed icon-wrench">$ContactNumber</div><% end_if %>
        </div>
        <div class="tradesmen-list__tile__details__location-lister business-services">
            <div class="tradesmen-list__tile__details__location-lister__location">
                <h3>Services</h3>
                <div class="services">
                    <% loop $Services.limit(5) %>
                        <span class="tradesmen-list__tile__details__location-lister__location__service">$Title</span>
                    <% end_loop %>
                    <% if $Services.Count > 5 %>
                        ...
                    <% end_if %>
                </div>
            </div>
        </div>
    </div>
    <div class="tradesmen-list__tile__actions as-flex wrap space-between">
        <a class="blue-button inline-block" href="$Link">More details</a>
        <ul class="rating">
            <li class="icon-star"></li>
            <li class="icon-star"></li>
            <li class="icon-star"></li>
            <li class="icon-star-half"></li>
            <li class="icon-star-empty"></li>
        </ul>
    </div>
</div>

<div class="tradesmen-list__tile column is-half">
    <a href="$Link" class="tradesmen-list__tile__cover business-logo">
        <% if $Logo %>$Logo.FillMax(580, 338)<% else %><img src="https://placehold.it/580x338" /><% end_if %>
    </a>
    <div class="tradesmen-list__tile__details columns is-marginless relative">
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
    <div class="tradesmen-list__tile__actions columns space-between is-marginless">
        <a class="blue-button inline-block" href="$Link">More details</a>
        <ul class="rating" data-sid="$SecurityID" data-uid="$Member.ID">
            <%-- $Member.getRating(1) --%>
            <% with $Member.Rating %>
                <ul class="rating<% if $Rated %> rated<% end_if %>" data-sid="$SecurityID" data-type="Member" data-id="$Up.ID">
                    $HTML
                </ul>
                <span class="rating-count">($Count rating<% if $Count > 1 %>s<% end_if %>)</span>
            <% end_with %>
        </ul>
    </div>
</div>

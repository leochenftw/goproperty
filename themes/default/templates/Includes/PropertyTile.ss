<div class="property-list__tile column is-half">
    <a href="$Link" class="property-list__tile__cover" style="background-image: url(<% if $Gallery %>$Gallery.First.FillMax(580, 338).URL<% else %>https://placehold.it/580x338<% end_if %>);">
        <div class="property-list__tile__cover__bath-bed">
            <span class="icon"><i class="fa fa-bath"></i>$NumBathrooms</span>
            <span class="icon"><i class="fa fa-bed"></i>$NumBedrooms</span>
        </div>
    </a>
    <div class="property-list__tile__details columns is-marginless relative">
        <div class="property-list__tile__details__price">$Price</div>
        <div class="property-list__tile__details__location-lister">
            <div class="property-list__tile__details__location-lister__lister">
                <% if $Agency %>
                    <% if $Agency.Logo %>
                        $Agency.Logo.Cropped.FillMax(75,75)
                    <% else %>
                        <img src="/themes/default/images/default-portrait.png" width="75" height="75" />
                    <% end_if %>
                <% else %>
                    <% if $Member.Portrait.Image.Cropped %>
                        $Member.Portrait.Image.Cropped.FillMax(75,75)
                    <% else %>
                        <img src="/themes/default/images/default-portrait.png" width="75" height="75" />
                    <% end_if %>
                <% end_if %>
            </div>
            <div class="property-list__tile__details__location-lister__location">
                <% if $UnitNumber %>$UnitNumber, <% end_if %> $StreetNumber $StreetName
                <% if $Suburb %><br />$Suburb<% end_if %>
                <% if $City %><br />$City<% end_if %>
                <% if $Region %><br />$Region<% end_if %>
            </div>
        </div>
    </div>
    <div class="property-list__tile__actions columns is-marginless is-mobileFlex">
        <div class="column is-auto-width">
            <a class="blue-button inline-block" href="$Link">More details</a>
        </div>
        <ul class="rating column" data-sid="$SecurityID" data-uid="$Member.ID">
            <% with $Rating %>
                <ul class="rating<% if $Rated %> rated<% end_if %>" data-sid="$SecurityID" data-type="PropertyPage" data-id="$Top.ID">
                    $HTML
                </ul>
                <span class="rating-count">($Count rating<% if $Count > 1 %>s<% end_if %>)</span>
            <% end_with %>
        </ul>
    </div>
</div>

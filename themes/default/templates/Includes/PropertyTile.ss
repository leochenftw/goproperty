<div class="property-list__tile">
    <a href="$Link" class="property-list__tile__cover" style="background-image: url(<% if $Gallery %>$Gallery.First.FillMax(580, 338).URL<% else %>https://placehold.it/580x338<% end_if %>);">
        <div class="property-list__tile__cover__bath-bed">
            <span class="icon-bath">$NumBathrooms</span>
            <span class="icon-bed">$NumBedrooms</span>
        </div>
    </a>
    <div class="property-list__tile__details as-flex wrap space-between relative">
        <div class="property-list__tile__details__price">$Price</div>
        <div class="property-list__tile__details__location-lister">
            <div class="property-list__tile__details__location-lister__lister">
                $Member.Portrait.Image.Cropped.FillMax(75,75)
            </div>
            <div class="property-list__tile__details__location-lister__location">
                <% if $UnitNumber %>$UnitNumber, <% end_if %> $StreetNumber $StreetName
                <% if $Suburb %><br />$Suburb<% end_if %>
                <% if $City %><br />$City<% end_if %>
                <% if $Region %><br />$Region<% end_if %>
            </div>
        </div>
    </div>
    <div class="property-list__tile__actions as-flex wrap space-between">
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

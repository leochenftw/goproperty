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
    <div class="property-list__tile__actions columns is-marginless">
        <div class="column is-auto-width">
            <a class="blue-button inline-block" href="$Link">More details</a>
        </div>
        <ul class="rating column" data-sid="$SecurityID" data-uid="$Member.ID">
            $Member.getRating(1)
        </ul>
    </div>
</div>

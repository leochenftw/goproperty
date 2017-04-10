<% include GooglemapsHero Lat=$Lat, Lng=$Lng %>
<section class="section property">
    <div class="container title">
        <header>
            <h1>$Title</h1>
            <p><strong>${$WeeklyRent} per week</strong> Available $DateAvailable.Day, $DateAvailable.Long</p>
        </header>
        <% include PropertyGallery %>
    </div>
    <div class="property__content-area container as-flex wrap">
        <aside class="property__content-area__aside">
            <dl>
                <% if $FullAddress %>
                    <dt>Location</dt>
                    <dd><% if $UnitNumber %>$UnitNumber, <% end_if %>$FullAddress</dd>
                <% end_if %>
                <dt>Property type</dt>
                <dd>$PropType</dd>
                <% if $DateAvailable %>
                    <dt>Available</dt>
                    <dd>$DateAvailable.Day, $DateAvailable.Long</dd>
                <% end_if %>
                <% if $Furnishings %>
                    <dt>Furnishing</dt>
                    <dd>$Friendlify($Furnishings)</dd>
                <% end_if %>
                <% if $Amenities %>
                    <dt>In the area</dt>
                    <dd>$Friendlify($Amenities)</dd>
                <% end_if %>
                <% if $RentOrSale == 'rent' %>
                    <dt>Pet OK</dt>
                    <dd>$AllowPet</dd>
                    <dt>Smoker OK</dt>
                    <dd>$AllowSmoker</dd>
                <% end_if %>
                <dt>Smoke alarm</dt>
                <dd><% if $SmokeAlarm %>Yes<% else %>No<% end_if %></dd>
                <dt>Insulation</dt>
                <dd><% if $Insulation %>Yes<% else %>No<% end_if %></dd>
                <dt>Parking</dt>
                <dd>$ParkingOption</dd>
                <% if $IdealTenants %>
                    <dt>Ideal tenants</dt>
                    <dd>$TenantOption</dd>
                <% end_if %>
            </dl>
            <div class="property__content-area__aside__map-holder">
                <div class="property__content-area__aside__map-holder__map google-maps-holder" data-lat="$Lat" data-lng="$Lng"></div>
            </div>
        </aside>
        <article class="property__content-area__content">
            <div class="content">
                $Friendlify($Content)
                <div class="social">
                    <% if $CurrentMember %>
                        <div class="as-inline-block wishlist-holder"><a class="icon-heart<% if not $isWished %>-empty<% end_if %> btn-fav" href="/api/v1/fav" data-class="$ClassName" data-id="$ID">Wishlist<% if $isWished %>ed<% end_if %></a></div>
                    <% end_if %>
                    <div class="<% if $CurrentMember %>as-inline-block <% end_if %>addthis_inline_share_toolbox"></div>
                </div>
            </div>

            <% include MemberTile %>

            <div class="property__content-area__testimonial">
                <h2 class="title">Testimonial</h2>
                $Friendlify($Testimonial)
            </div>
        </article>
    </div>
</section>

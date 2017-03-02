<div class="hero-region" id="g-map-hero-wrapper">
    <div class="hero-region__google-maps" id="g-map-hero" data-lat="$Lat" data-lng="$Lng"></div>
    <% if $TextOverlay %>
    <div class="container hero-region__text-overlay">
        <$TextWrapper>$TextOverlay</$TextWrapper>
    </div>
    <% end_if %>
</div>

<div id="property-gallery" class="property__gallery column is-12">
    <div id="property-image-viewer" class="property__gallery__image-viewer">
        <% if $Gallery %>
            <% with $Gallery.First.FillMax(1200, 680) %>
                <img src="$URL" width="$Width" height="$Height" alt="" />
            <% end_with %>
        <% else %>
            <img src="https://via.placeholder.com/1200x680" alt="default image" />
        <% end_if %>
    </div>
    <% if $Gallery %>
    <div class="owl-carousel property__gallery__thumbnails">
        <% loop $Gallery %>
            <a href="$SetHeight(680).URL" class="property__gallery__thumbnails__thumbnail thumbnail">
                $FillMax(150, 90)
            </a>
        <% end_loop %>
    </div>
    <% end_if %>
</div>

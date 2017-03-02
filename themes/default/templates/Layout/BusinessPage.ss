<% include GooglemapsHero Lat=$Business.Lat, Lng=$Business.Lng %>
<section class="section property">
    <div class="container title">
        <header>
            <h1 class="business">$Business.Title</h1>
        </header>
    </div>
    <div class="property__content-area business container as-flex wrap">
        <aside class="property__content-area__aside">
            <% if $Business.Logo %>
                $Business.Logo.SetWidth(560)
            <% end_if %>
            <dl>
                <% if $Business.FullAddress %>
                    <dt>Location</dt>
                    <dd>$Business.FullAddress</dd>
                <% end_if %>
                <% if $Business.ContactNumber %>
                    <dt>Contact number</dt>
                    <dd>$Business.ContactNumber</dd>
                <% end_if %>
            </dl>
            <div class="property__content-area__aside__map-holder">
                <div class="property__content-area__aside__map-holder__map google-maps-holder" data-lat="$Business.Lat" data-lng="$Business.Lng"></div>
            </div>
        </aside>
        <article class="property__content-area__content">
            <div class="services">
                <h2>Services</h2>
                <% loop $Business.Services %>
                    <span>$Title</span>
                <% end_loop %>
            </div>
            <div class="content">
                <h2>Introduction</h2>
                $Business.Friendlify($Business.Content)
            </div>
            <% include MemberTile Member=$Business.BusinessOwner %>
            <div class="property__content-area__testimonial">
                <h2 class="title">Testimonial</h2>
                <% if $Business.Testimonial %>
                    $Business.Friendlify($Business.Testimonial)
                <% else %>
                    <p>No Testimonial just yet.</p>
                <% end_if %>
            </div>
        </article>
    </div>
</section>

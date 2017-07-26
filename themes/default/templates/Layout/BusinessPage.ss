<% include GooglemapsHero Lat=$Business.Lat, Lng=$Business.Lng %>
<section class="section property">
    <div class="container">
        <nav class="breadcrumb">
        <% loop $LocationBreadcrumbs %>
            <% if $URL %>
            <a href="$URL" class="breadcrumb-item">$Title</a>
            <% else %>
                <span class="breadcrumb-item is-active">$Title</span>
            <% end_if %>
        <% end_loop %>
        </nav>
        <header class="column is-12">
            <h1 class="title is-2 is-bold is-uppercase">$Business.Title</h1>
        </header>

        <div class="property__content-area business columns is-marginless">
            <aside class="property__content-area__aside column">
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
            <article class="property__content-area__content column">
                <div class="services">
                    <h2 class="title is-3 is-bold">Services</h2>
                    <% loop $Business.Services %>
                        <span>$Title</span>
                    <% end_loop %>
                </div>
                <div class="content">
                    <h2 class="title is-3 is-bold">Introduction</h2>
                    $Business.Friendlify($Business.Content)
                    <div class="social">
                        <% if $CurrentMember %>
                            <div class="as-inline-block wishlist-holder"><a class="icon-heart<% if not $Business.isWished %>-empty<% end_if %> btn-fav" href="/api/v1/fav" data-class="$Business.ClassName" data-id="$Business.ID">Wishlist<% if $Business.isWished %>ed<% end_if %></a></div>
                        <% end_if %>
                        <div class="<% if $CurrentMember %>as-inline-block <% end_if %>addthis_inline_share_toolbox"></div>
                    </div>
                </div>
                <% include MemberTile Member=$Business.BusinessOwner %>
                <div class="property__content-area__testimonial">
                    <h2 class="title">Testimonial</h2>
                    <%-- <% if $Business.Testimonial %>
                        $Business.Friendlify($Business.Testimonial)
                    <% else %>
                        <p>No Testimonial just yet.</p>
                    <% end_if %> --%>
                    <% if $Business.Comments %>
                        <div class="comments">
                        <% loop $Business.Comments %>
                            <div class="comment">
                                <h3 class="title is-5">$Member.DisplayName</h3>
                                <p class="subtitle is-6">$When</p>
                                <p class="ratings" data-id="$ID" data-stars="$Stars">
                                    <span class="icon"><i class="fa fa-star-o"></i></span>
                                    <span class="icon"><i class="fa fa-star-o"></i></span>
                                    <span class="icon"><i class="fa fa-star-o"></i></span>
                                    <span class="icon"><i class="fa fa-star-o"></i></span>
                                    <span class="icon"><i class="fa fa-star-o"></i></span>
                                </p>
                                <p>$Comment</p>
                            </div>
                        <% end_loop %>
                        </div>
                    <% else %>
                        <p>No Testimonial just yet.</p>
                    <% end_if %>
                </div>
            </article>
        </div>
    </div>
</section>

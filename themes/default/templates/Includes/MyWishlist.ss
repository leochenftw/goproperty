<h2 class="title is-3 is-bold">My wishlist</h2>
<ul class="member-area__content__property-list">
<% if $MyWishlist %>
    <% loop $MyWishlist %>
        <li class="columns is-flex-mobile member-area__content__property-list__item<% if $isGone %> no-longer-available<% end_if %>">
            <a href="$Link" class="column is-auto-width member-area__content__property-list__item__image">
                <% if $ClassName == 'PropertyPage' %>
                    <% if $Gallery.Count > 0 %>
                        <% with $Gallery.First.FillMax(50, 50) %>
                            <img class="as-block" src="$URL" width="50" height="50" alt="$Title" />
                        <% end_with %>
                    <% else %>
                        <img class="as-block" src="https://placehold.it/50x50" width="50" height="50" alt="" />
                    <% end_if %>
                <% end_if %>
                <% if $ClassName == 'Business' %>
                    <% if $Logo %>
                        <% with $Logo.FillMax(50, 50) %>
                            <img class="as-block" src="$URL" width="50" height="50" alt="$Title" />
                        <% end_with %>
                    <% else %>
                        <img class="as-block" src="https://placehold.it/50x50" width="50" height="50" alt="" />
                    <% end_if %>
                <% end_if %>
            </a>
            <div class="column member-area__content__property-list__item__info">
                <p class="subtitle is-6"><% if $ClassName == 'PropertyPage' %>Property for $RentOrSale<% end_if %><% if $ClassName == 'Business' %>Tradeperson<% end_if %></p>
                <h3 class="title is-5">$Title</h3>
            </div>
            <div class="column member-area__content__property-list__item__actions is-auto-width">
                <a class="button inline" href="$Link">View</a>
                <a class="btn-rm-fav button red inline" href="/api/v1/fav" data-class="$ClassName" data-id="$ID">Remove</a>
            </div>
        </li>
    <% end_loop %>
<% else %>
    <div class="content">
        <p>You don't have any item in your wishlist.</p>
    </div>
<% end_if %>
</ul>

<h2 class="title is-3 is-bold">Properties</h2>
<div class="control-buttons as-flex wrap">
    <a data-title="Dashboard | Create a new property" href="/member/action/manage-property" class="ajax-routed">Add new property</a>
</div>
<ul class="member-area__content__property-list">
<% loop $Properties %>
    <li class="columns member-area__content__property-list__item">

        <a href="#" data-expect-form="1" class="column is-auto-width member-area__content__property-list__item__image">
            <% if $Gallery.Count > 0 %>
                <% with $Gallery.First.FillMax(100, 100) %>
                    <img class="as-block" src="$URL" width="100" height="100" alt="$Title" />
                <% end_with %>
            <% else %>
                <img class="as-block" src="https://placehold.it/100x100" width="100" height="100" alt="" />
            <% end_if %>
        </a>
        <div class="column member-area__content__property-list__item__info">
            <h3 class="title is-5">$Title</h3>
            <div class="is-marginless member-area__content__property-list__item__info__controls">
                <a class="btn-listing button outlined inline" data-expect-form="1" href="/member/action/manage-property?id=$ID&step=5">Edit property</a>
                <%-- <% if $RentalListings.Count > 0 %> --%>
                    <a class="btn-listing button outlined inline" href="/member/action/rental-listings?id=$ID">Rental listings</a>
                <%-- <% else %>
                    <a class="btn-listing button outlined inline" data-expect-form="1" href="/member/action/rental-listing?id=$ID">Rent it</a> --%>
                <%-- <% end_if %> --%>
                <a class="btn-listing button outlined inline" href="/member/action/sale-listing?id=$ID">Sell it</a>
            </div>
            <div class="forms"></div>
        </div>
    </li>
<% end_loop %>
</ul>

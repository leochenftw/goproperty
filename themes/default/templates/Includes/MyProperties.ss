<h2 class="title is-3 is-bold">My properties</h2>
<div class="control-buttons as-flex wrap">
    <a data-title="Dashboard | List a property for rent" href="/member/action/list-property-for-rent" class="ajax-routed">List for rent</a>
    <% if $isAgent %>
    <a data-title="Dashboard | List a property for sale" href="/member/action/list-property-for-sale" class="ajax-routed">List for sale</a>
    <% end_if %>
</div>
<ul class="member-area__content__property-list">
<% loop $MyProperties %>
    <li class="columns member-area__content__property-list__item">

        <a href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID" class="column is-auto-width member-area__content__property-list__item__image">
            <% if $Gallery.Count > 0 %>
                <% with $Gallery.First.FillMax(100, 100) %>
                    <img class="as-block" src="$URL" width="100" height="100" alt="$Title" />
                <% end_with %>
            <% else %>
                <img class="as-block" src="https://placehold.it/100x100" width="100" height="100" alt="" />
            <% end_if %>
        </a>
        <div class="column member-area__content__property-list__item__info">
            <h3 class="title is-5">
                <span class="type">$RentOrSale.UpperCase</span> $Title
                <span class="subtitle is-6 status"> -
                    <% if $isGone %>
                        Rented
                    <% else %>
                        <% if $isPublished %>
                            Listed
                        <% else %>
                            Draft
                        <% end_if %>
                    <% end_if %>
                </span>
            </h3>
            <div class="is-marginless member-area__content__property-list__item__info__controls">
                <% if $isGone %>
                    Rented
                <% else %>
                    <% if $isPublished %>
                        Listed
                    <% else %>
                            <a class="button inline" href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID">Edit</a>
                            <a class="button inline" href="$Link">List</a>
                    <% end_if %>
                <% end_if %>
            </div>
        </div>
    </li>
<% end_loop %>
</ul>

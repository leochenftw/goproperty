<h2 class="title">My agencies</h2>
<div class="control-buttons as-flex wrap">
    <a data-title="Dashboard | Create a new agency" href="/member/action/edit-agency" class="ajax-routed">Create new agency</a>
</div>
<% if $Agencies.Count == 0 %>
    <p>You haven't joined any agency</p>
<% else %>
<ul class="member-area__content__property-list">
<% loop $Agencies %>
    <li class="columns member-area__content__property-list__item">
        <a href="/member/action/manage-property?id=$ID&step=5" data-expect-form="1" class="column is-auto-width member-area__content__property-list__item__image">
            <% if $Logo > 0 %>
                <% with $Logo.FillMax(100, 100) %>
                    <img class="as-block" src="$URL" width="100" height="100" alt="$Title" />
                <% end_with %>
            <% else %>
                <img class="as-block" src="https://placehold.it/100x100" width="100" height="100" alt="" />
            <% end_if %>
        </a>
        <div class="column member-area__content__property-list__item__info">
            <h3 class="title is-3">$Title</h3>
            <div class="is-marginless member-area__content__property-list__item__info__controls">
                <a class="btn-listing button outlined inline" data-expect-form="1" href="/member/action/edit-agency?agency_id=$ID&step=5">Edit property</a>
            </div>
            <div class="forms"></div>
        </div>
    </li>
<% end_loop %>
</ul>
<% end_if %>

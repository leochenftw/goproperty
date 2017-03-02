<h2 class="title">
    <span>My agencies</span>
    <a data-title="Dashboard | Cancel subscription" href="/member/action/cancel-subscription" class="ajax-routed<% if $tab == 'cancel-subscription' %> active<% end_if %>">
    <% if $Subscription %>
        Cancel subscription
    <% else_if $ActiveSubscription %>
        Extend subscription
    <% end_if %>
    </a>
</h2>
<form class="mini-ajax-form" method="POST" action="/api/v1/agency">
    <input name="agency_title" type="text" required placeholder="The name of your agency" />
    <input type="hidden" name="agency_id" />
    <input type="hidden" name="SecurityID" value="$SecurityID" />
    <button type="submit">Join</button>
</form>
<% loop $Agencies %>
    $Title
<% end_loop %>

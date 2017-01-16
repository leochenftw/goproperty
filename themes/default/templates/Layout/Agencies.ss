<h2 class="title">My agencies</h2>

<form class="mini-ajax-form" method="POST" action="/api/v1/agency">
    <input name="agency_title" type="text" required placeholder="The name of your agency" />
    <input type="hidden" name="agency_id" />
    <input type="hidden" name="SecurityID" value="$SecurityID" />
    <button type="submit">Join</button>
</form>
<% loop $Agencies %>
    $Title
<% end_loop %>

<h2 class="title">My properties</h2>
<div class="control-buttons as-flex wrap">
    <a data-title="Dashboard | List a property for rent" href="/member/action/list-property-for-rent" class="ajax-routed">List for rent</a>
    <% if $isAgent %>
    <a data-title="Dashboard | List a property for sale" href="/member/action/list-property-for-sale" class="ajax-routed">List for sale</a>
    <% end_if %>
</div>
<ul class="neat-ul">
<% loop $MyProperties %>
    <li><a href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID">[$RentOrSale] $Title</a></li>
<% end_loop %>
</ul>

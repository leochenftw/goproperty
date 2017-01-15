<h2 class="title">My properties</h2>
<ul class="neat-ul">
<% loop $MyProperties %>
    <li><a href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID">[$RentOrSale] $Title</a></li>
<% end_loop %>
</ul>

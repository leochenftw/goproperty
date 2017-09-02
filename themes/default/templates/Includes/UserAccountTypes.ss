<% if $ShowDetails %>
<ul class="detailed-account-types li-inline-block">
    <% if $CurrentMember.isLandlord %>
    <li class="icon-property">
        <h4>Landlord</h4>
    </li>
    <% end_if %>
    <% if $CurrentMember.isRealtor %>
    <li class="icon-agency">
        <h4>Realtor</h4>
    </li>
    <% end_if %>
    <% if $CurrentMember.isTradesperson %>
    <li class="icon-wrench">
        <h4>Tradesperson</h4>
    </li>
    <% end_if %>
</ul>
<% else %>
<ul class="account-types roles-inline">
    <% if $CurrentMember.isLandlord %>
        <li class="checked">
            <h4>Landlord</h4>
            <p>You can list properties for rent.</p>
        </li>
    <% end_if %>
    <% if $CurrentMember.isRealtor %>
        <li class="checked">
            <h4>Realtor</h4>
            <p>You can list properties for rent and sale.</p>
        </li>
    <% end_if %>
    <% if $CurrentMember.isTradesperson %>
        <li class="checked">
            <h4>Tradesperson</h4>
            <p>You can list your business and services, and take job from the public.</p>
        </li>
    <% end_if %>

    <%-- this needs to go --%>
    <% if $CurrentMember.inGroup('testa') %>
        <li class="checked">
            <h4>Test A</h4>
            <p>$1.00 test.</p>
        </li>
    <% end_if %>

    <% if $CurrentMember.inGroup('testb') %>
        <li class="checked">
            <h4>Test B</h4>
            <p>$1.50 test.</p>
        </li>
    <% end_if %>
    <%-- this needs to go --%>
</ul>
<% end_if %>

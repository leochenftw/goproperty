<% include GooglemapsHero TextOverlay=$CurrentUser.Title, TextWrapper=h1, Lat=$CurrentUser.Lat, Lng=$CurrentUser.Lng %>
<div class="section">
    <div class="container member-area as-flex wrap<% if $tab == 'list-property-for-rent' || $tab == 'list-property-for-sale' %> slim-aside<% end_if %>">
        <aside class="member-area__sidebar">
            <ul class="neat-ul">
                <% if not $isAgent || not $isLandlord || not $isTradesperson %>
                <li>
                <a title="<% if $NeedsToPay %>Account<% else %>Account upgrade<% end_if %>" data-title="Dashboard | Upgrade account" href="/member/action/upgrade" class="icon-promote ajax-routed<% if $tab == 'upgrade' %> active<% end_if %>"><span><% if $NeedsToPay %>Account<% else %>Account upgrade<% end_if %></span></a>
                </li>
                <% end_if %>
                <li><a title="My profile" data-title="Dashboard | My profile" href="/member/action/profile" class="icon-user ajax-routed<% if $tab == 'profile' || not $tab || $tab == 'email-update' %> active<% end_if %>"><span>My profile</span></a></li>
                <li><a title="Change password" data-title="Dashboard | Change password" href="/member/action/password" class="icon-key ajax-routed<% if $tab == 'password' %> active<% end_if %>"><span>Change password</span></a></li>
                <% if $isAgent %>
                <li>
                    <a title="My agencies" data-title="Dashboard | My agencies" href="/member/action/agencies" class="icon-agency ajax-routed<% if $tab == 'agencies' %> active<% end_if %>"><span>My agencies</span></a>
                </li>
                <% end_if %>
                <% if $isAgent || $isLandlord %>
                <li><a title="My properties" data-title="Dashboard | My properties" href="/member/action/my-properties" class="icon-property ajax-routed<% if $tab == 'my-properties' %> active<% end_if %>"><span>My properties</span></a></li>
                <% end_if %>
                <% if $isTradesperson %>
                <li><a title="My business" data-title="Dashboard | My business" href="/member/action/my-business" class="icon-wrench ajax-routed<% if $tab == 'my-business' %> active<% end_if %>"><span>My Business</span></a></li>
                <% end_if %>
                <li><a title="Payment history" data-title="Dashboard | Payment history" href="/member/action/payment-history" class="icon-dollar ajax-routed<% if $tab == 'payment-history' %> active<% end_if %>"><span>Payment history</span></a></li>
                <li><a title="My credit card" data-title="Dashboard | My credit card" href="/member/action/creditcards" class="icon-creditcard ajax-routed<% if $tab == 'creditcards' %> active<% end_if %>"><span>My credit card</span></a></li>
                <li><a title="" href="/member/signout" class="icon-logout"><span>Sign out</span></a></li>
            </ul>
        </aside>

        <div class="member-area__content">
            <% if $tab == 'profile' || not $tab %>
                <h2 class="title">Member profile</h2>
                <% if not $EmailisValidated %>
                <% include EmailNotValidated %>
                <% end_if %>
                <div class="account-types-holder">
                    <h3>Subscribed account type(s)</h3>
                    <% include UserAccountTypes ShowDetails=1 %>
                </div>
                $MemberProfileForm
            <% end_if %>

            <% if $tab == 'my-business' %>
                <% include MyBusiness %>
            <% end_if %>

            <% if $tab == 'agencies' %>
                <% include Agencies %>
            <% end_if %>

            <% if $tab == 'edit-agency' %>
                <% include AgencyForm %>
            <% end_if %>

            <% if $tab == 'creditcards' %>
                <% include Creditcards %>
            <% end_if %>

            <% if $tab == 'my-properties' %>
                <% include MyProperties %>
            <% end_if %>

            <% if $tab == 'password' %>
                <h2 class="title">Change password</h2>
                $UpdatePasswordForm
            <% end_if %>

            <% if $tab == 'email-update' %>
                <h2 class="title">Change email address</h2>
                $UpdateEmailForm
            <% end_if %>

            <% if $tab == 'list-property-for-rent' %>
                <h2 class="title"><% if $RentForm.FormTitle %>$RentForm.FormTitle<% else %>List a property for rent<% end_if %></h2>
                $RentForm
            <% end_if %>

            <% if $tab == 'list-property-for-sale' %>
                <h2 class="title"><% if $SaleForm.FormTitle %>$SaleForm.FormTitle<% else %>List a property for sale<% end_if %></h2>
                $SaleForm
            <% end_if %>

            <% if $tab == 'payment-history' %>
                <% include PaymentHistory %>
            <% end_if %>

            <% if $tab == 'upgrade' %>
                <% include AccountUpgradeForm %>
            <% end_if %>

            <% if $tab == 'cancel-subscription' %>
                <% include SubscriptionManager %>
            <% end_if %>
        </div>
    </div>
</div>

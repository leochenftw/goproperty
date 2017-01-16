<div class="section hero">
	<div class="container">
		<h1>$CurrentUser.FirstName $CurrentUser.Surname</h1>
		<div class="breadcrumb">$Breadcrumbs</div>
	</div>
</div>

<div class="section">
	<div class="container member-area">
		<aside class="member-area__sidebar">
			<ul class="neat-ul">
				<li><a data-title="Dashboard | My profile" href="/member/action/profile" class="ajax-routed<% if $tab == 'profile' || not $tab || $tab == 'email-update' %> active<% end_if %>">My profile</a></li>
                <% if $isAgent %>
                <li><a data-title="Dashboard | My agencies" href="/member/action/agencies" class="ajax-routed<% if $tab == 'agencies' %> active<% end_if %>">My agencies</a></li>
                <% end_if %>
                <li>
                    <a data-title="Dashboard | My properties" href="/member/action/my-properties" class="ajax-routed<% if $tab == 'my-properties' %> active<% end_if %>">My properties</a>
                    <ul class="neat-ul">
                        <li><a data-title="Dashboard | List a property for rent" href="/member/action/list-property-for-rent" class="ajax-routed<% if $tab == 'list-property-for-rent' %> active<% end_if %>">List a property for rent</a></li>
                        <% if $isAgent %>
                        <li><a data-title="Dashboard | List a property for sale" href="/member/action/list-property-for-sale" class="ajax-routed<% if $tab == 'list-property-for-rent' %> active<% end_if %>">List a property for sale</a></li>
                        <% end_if %>
                    </ul>
                </li>
                <li><a data-title="Dashboard | Payment history" href="/member/action/payment-history" class="ajax-routed<% if $tab == 'payment-history' %> active<% end_if %>">Payment history</a></li>
                <li><a data-title="Dashboard | My creditcards" href="/member/action/creditcards" class="ajax-routed<% if $tab == 'creditcards' %> active<% end_if %>">My creditcards</a></li>
				<li><a data-title="Dashboard | Change password" href="/member/action/password" class="ajax-routed<% if $tab == 'password' %> active<% end_if %>">Change password</a></li>
				<li><a href="/member/signout">Sign out</a></li>
			</ul>
            <% if $isAgent %>
                <a data-title="Dashboard | Cancel subscription" href="/member/action/cancel-subscription" class="ajax-routed<% if $tab == 'cancel-subscription' %> active<% end_if %>">Cancel subscription</a>
            <% else %>
                <a data-title="Dashboard | Upgrade account" href="/member/action/upgrade" class="ajax-routed<% if $tab == 'upgrade' %> active<% end_if %>">Upgrde to trademan acount</a>
            <% end_if %>
		</aside>

		<div class="member-area__content">
			<% if $tab == 'profile' || not $tab %>
				<h2 class="title">Member profile</h2>
                <% if not $EmailisValidated %>
                <% include EmailNotValidated %>
                <% end_if %>
				$MemberProfileForm
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

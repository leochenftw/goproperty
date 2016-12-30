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
				<li><a data-title="Dashboard | Change password" href="/member/action/password" class="ajax-routed<% if $tab == 'password' %> active<% end_if %>">Change password</a></li>
				<li><a href="/member/signout">Sign out</a></li>
			</ul>
		</aside>

		<div class="member-area__content">
			<% if $tab == 'profile' || not $tab %>
				<h2 class="title">Member profile</h2>
                <% if not $EmailisValidated %>
                <% include EmailNotValidated %>
                <% end_if %>
				$MemberProfileForm
			<% end_if %>

			<% if $tab == 'password' %>
				<h2 class="title">修改登录密码</h2>
				$UpdatePasswordForm
			<% end_if %>

			<% if $tab == 'email-update' %>
				<h2 class="title">修改邮箱地址</h2>
				$UpdateEmailForm
			<% end_if %>
		</div>
	</div>
</div>

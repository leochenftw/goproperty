<div class="section hero">
	<div class="container">
		<h1>$Title</h1>
		<div class="breadcrumb">$Breadcrumbs</div>
	</div>
</div>

<div class="section">
	<div class="container">

		<% with $SignupForm %>
            <% if $Message %>
            <div class="message-wrapper $Message.MessageType">$Message</div>
            <% end_if %>
			<form $FormAttributes>
				<div class="fields">
					<% loop $Fields %>
						<% if $Name != 'Subscribe' %>
							$FieldHolder
						<% else %>
							<div class="as-flex">
								$FieldHolder
							</div>
						<% end_if %>
					<% end_loop %>
				</div>
				<div class="Actions">
					$Actions
				</div>
				<div class="lnk-signup-wrapper margin-h-10-0-0 text-center"><a href="/signin?backURL=/member">Sign in</a></div>
			</form>
            $clearMessage
		<% end_with %>
	</div>
</div>

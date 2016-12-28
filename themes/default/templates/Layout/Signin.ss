<div class="section hero">
	<div class="container">
		<h1>$Title</h1>
		<div class="breadcrumb">$Breadcrumbs</div>
	</div>
</div>

<div class="section">
	<div class="container">
		<% with $SigninForm %>
            <% if $Message %>
            <div class="message-wrapper $Message.MessageType">$Message</div>
            <% end_if %>
			<form $FormAttributes>
				<div class="fields">
					$Fields
					$Actions.Last
				</div>
				<div class="Actions">
					$Actions.First
				</div>
				<div class="lnk-signup-wrapper margin-h-10-0-0 text-center"><a href="/signup">Sign up</a></div>
			</form>
            $clearMessage
		<% end_with %>
	</div>
</div>

<h2 class="title">Change passwordz</h2>
<% with $UpdatePasswordForm %>
    <% if $Message %>
    <div class="notification $MessageType">$Message</div>
    <% end_if %>
    <form $FormAttributes>
        <fieldset>
            $Fields
        </fieldset>
        <div class="Actions">$Actions</div>
    </form>
<% end_with %>

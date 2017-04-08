<h2>My business</h2>

<% with $BusinessForm %>
<form $FormAttributes>
    <fieldset>
        <div class="fields">
            <% loop $Fields %>
                <% if $Type != 'composite' %>
                    $FieldHolder
                <% else %>
                    <div class="service-group services">
                        <h3 class="title">Services</h3>
                        $FieldHolder
                    </div>
                <% end_if %>
            <% end_loop %>
        </div>
    </fieldset>
    <div class="Actions">
        $Actions.First
    </div>
</form>
<% end_with %>

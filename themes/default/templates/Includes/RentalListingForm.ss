<div class="ajax-content">
    <div class="columns is-marginless vertical-bottom">
        <div class="column is-paddingless"><h4 class="title">Create new rental listing</h4></div>
    </div>
<% with $RentalListingForm %>
    <form $FormAttributes>
        <fieldset>
            $Fields
        </fieldset>
        <div class="Actions">
            <nav class="pagination is-centered">
                <% if $Actions.Count == 1 %>
                <a href="#" class="pagination-previous do-cancel">Cancel</a>
                <% end_if %>
                $Actions
            </nav>
        </div>
    </form>
<% end_with %>
</div>

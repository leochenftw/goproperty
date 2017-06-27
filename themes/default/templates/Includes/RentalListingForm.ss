<div class="ajax-content">
    <div class="columns is-marginless vertical-bottom">
        <div class="column is-paddingless"><h4 class="title">Create new listing</h4></div>
    </div>
<% with $RentalListingForm %>
    <form $FormAttributes>
        <fieldset>
            $Fields
        </fieldset>
        <div class="Actions">
            <nav class="pagination is-centered">
                $Actions
            </nav>
        </div>
    </form>
<% end_with %>
</div>

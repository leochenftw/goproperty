<div class="ajax-content">
    <div class="columns is-marginless vertical-bottom">
        <div class="column is-paddingless"><h4 class="title">Rental listings</h4></div>
        <div class="column is-paddingless is-auto-width has-text-right"><a class="btn-listing button outlined inline" href="/member/action/rental-listing?id=$Property.ID">New...</a></div>
    </div>
    <div class="all-listings">
    <% if $Property.RentalListings.Count > 0 %>
        <% loop $Property.RentalListings %>
        <div class="columns">
            <%-- <div class="column">
                <p class="subtitle is-6"><em>Created</em></p>
                <h4 class="title is-5">$Created.Format('Y-m-d')</h4>
            </div> --%>
            <div class="column">
                <p class="subtitle is-6"><em>List until</em></p>
                <h4 class="title is-5">$ListTil</h4>
            </div>
            <% if not $isPaid %>
            <div class="column">
                <p class="subtitle is-6"><em>Amount due</em></p>
                <h4 class="title is-5">$Amountdue</h4>
            </div>
            <div class="column is-auto-width actions">
                <p class="subtitle is-6"><em>Action</em></p>
                <h4 class="title is-5">
                    <a class="btn-listing button inline" href="/member/action/rental-listing?id=$Up.ID&listing-id=$ID">Edit</a>
                    <a class="btn-listing button inline" href="/api/v1/listing/$ID/pay">Pay</a>
                    <a class="btn-delete-listing button inline" href="/api/v1/listing/$ID/delete">Delete</a>
                </h4>
            </div>
            <% else %>
            <div class="column">
                <p class="subtitle is-6"><em>Status</em></p>
                <h4 class="title is-5 listing-status">$Status</h4>
            </div>

            <div class="column is-auto-width actions">
                <% if $Status != 'Finished' %>
                <p class="subtitle is-6"><em>Action</em></p>
                <h4 class="title is-5">
                    <a class="btn-listing button inline" href="/member/action/rental-listing?id=$Up.ID&listing-id=$ID">Edit</a>
                    <a class="btn-end-listing button inline" href="/api/v1/listing/$ID/end">End</a>
                </h4>
                <% end_if %>
            </div>
            <% end_if %>
        </div>
        <% end_loop %>
    <% else %>
        <p>No listing</p>
    <% end_if %>
    </div>
</div>

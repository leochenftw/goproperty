<div class="all-listings">
<% loop $Property.RentalListings %>
    <div class="columns">
        <div class="column">
            <p class="subtitle is-6"><em>Created</em></p>
            <h4 class="title is-5">$Created.Format('Y-m-d')</h4>
        </div>
        <div class="column">
            <p class="subtitle is-6"><em>List until</em></p>
            <h4 class="title is-5">$ListTil</h4>
        </div>
        <% if not $isPaid %>
        <div class="column">
            <p class="subtitle is-6"><em>Amount due</em></p>
            <h4 class="title is-5">$Amountdue</h4>
        </div>
        <div class="column">
            <p class="subtitle is-6"><em>Action</em></p>
            <h4 class="title is-5"><a class="btn-listing button inline" href="/member/action/rental-listing?id=$Up.ID&listing-id=$ID">Pay</a></h4>
        </div>
        <% else %>
        <div class="column">
            <p class="subtitle is-6"><em>Status</em></p>
            <h4 class="title is-5">$Status</h4>
        </div>
        <div class="column">
            <p class="subtitle is-6"><em>Action</em></p>
            <h4 class="title is-5">
                <a class="btn-listing button inline" href="/member/action/rental-listing?id=$Up.ID&listing-id=$ID">Edit listing</a>
                <a class="btn-listing button inline" href="/member/action/rental-listing?id=$Up.ID&listing-id=$ID">End</a>
            </h4>
        </div>
        <% end_if %>
    </div>
<% end_loop %>
</div>

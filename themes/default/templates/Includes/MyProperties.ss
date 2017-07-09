<h2 class="title is-3 is-bold">My properties</h2>
<div class="control-buttons as-flex wrap">
    <a data-title="Dashboard | List a property for rent" href="/member/action/list-property-for-rent" class="ajax-routed">List for rent</a>
    <% if $isAgent %>
    <a data-title="Dashboard | List a property for sale" href="/member/action/list-property-for-sale" class="ajax-routed">List for sale</a>
    <% end_if %>
</div>
<ul class="member-area__content__property-list">
<% loop $MyProperties %>
    <li class="columns member-area__content__property-list__item">

        <a href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID" class="column is-auto-width member-area__content__property-list__item__image">
            <% if $Gallery.Count > 0 %>
                <% with $Gallery.First.FillMax(100, 100) %>
                    <img class="as-block" src="$URL" width="100" height="100" alt="$Title" />
                <% end_with %>
            <% else %>
                <img class="as-block" src="https://placehold.it/100x100" width="100" height="100" alt="" />
            <% end_if %>
        </a>
        <div class="column member-area__content__property-list__item__info">
            <h3 class="title is-5">
                <span class="type">$RentOrSale.UpperCase</span> $Title
                <span class="subtitle is-6 status"> -
                    <% if $isGone %>
                        Rented
                    <% else %>
                        <% if $isPublished %>
                            Listed
                        <% else %>
                            Draft
                        <% end_if %>
                    <% end_if %>
                </span>
            </h3>
            <div class="is-marginless member-area__content__property-list__item__info__controls">
                <% if $isGone %>
                    <% loop $Occupants %>
                        <div class="columns">
                            <div class="column is-auto-width">
                                <% if $Renter.Portrait.Image %>$Renter.Portrait.Image.Cropped.FillMax(30,30)<% else %><img style="width: 30px;" src="/themes/default/images/default-portrait.png" /><% end_if %>
                            </div>
                            <div class="column"><em><strong>$Renter.DisplayName</strong></em>, $Start to $End <button data-property-id="$Up.ID" data-rental-id="$ID" data-sid="$SecurityID" class="btn-terminate button is-small is-danger">Terminate</button></div>
                        </div>
                    <% end_loop %>
                <% else %>
                    <% if $isPublished %>
                        <a class="button outlined inline" href="$Link">View</a>
                        <a class="button outlined inline" href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID#RentForm_RentForm_action_doWithdraw">Withdraw</a>
                        <a class="button outlined inline btn-view-applicants" data-title="<% if $RentOrSale == 'rent' %>Applicants<% else %>Potential buyers<% end_if %>" href="#" data-sid="$SecurityID" data-id="$ID"><% if $RentOrSale == 'rent' %>Applicants<% else %>Interested<% end_if %> <span class="bubble">($ApplicantsCount)</span></a>
                    <% else %>
                        <a class="button outlined inline" href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID">Edit</a>
                        <a class="button outlined inline" href="/member/action/list-property-for-{$RentOrSale}?property_id=$ID#footer">List</a>
                        <a class="btn-delete button outlined inline" href="/api/v1/property-page/$ID/delete" data-csrf="$SecurityID">Delete</a>
                    <% end_if %>
                <% end_if %>
            </div>
        </div>
    </li>
<% end_loop %>
</ul>

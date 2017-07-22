<h2 class="title is-3 is-bold">My trade</h2>
<% with $CurrentMember %>
<div class="columns member-area__content__business-list">
    <div class="column is-narrow member-area__content__business-list__logo">
        <% if $Business %>
            <% if $Business.Logo %>
                $Business.Logo.SetHeight(100)
            <% else %>
                <img src="https://via.placeholder.com/150x100" width="150" height="100" alt="logo place holder" />
            <% end_if %>
        <% else %>
            <img src="https://via.placeholder.com/150x100" width="150" height="100" alt="logo place holder" />
        <% end_if %>
    </div>
    <div class="column member-area__content__business-list__info">
        <% if $Business %>
            <h3 class="title is-4 is-bold">$Business.Title <a class="button inline" style="margin-left: 0.5em;" href="/member/action/edit-business">Edit</a></h3>
            <% with $Rating %>
            <div class="columns subtitle is-flex-mobile">
                <div class="column is-paddingless-vertical is-narrow"><ul class="rating<% if $Rated %> rated<% end_if %>" data-sid="$SecurityID" data-type="Member" data-id="$Up.ID">
                    $HTML
                </ul></div>
                <div class="column is-paddingless"><span class="rating-count" style="font-size: 16px;">($Count rating<% if $Count > 1 %>s<% end_if %>)</span></div>
            </div>
            <% end_with %>
            <p>$Business.FullAddress</p>
        <% else %>
            <a class="button" href="/member/action/edit-business">Create your business</a>
        <% end_if %>
    </div>
</div>
<% if $Business %>
<div class="tabs">
    <ul>
        <li class="is-active"><a class="hb-engaged auto-fire tab-requests" href="/api/v1/service-request/$Business.ID" data-csrf="$SecurityID" data-template="serviceRequesterTemplate">Requests</a></li>
        <li><a class="hb-engaged tab-appointments" href="/api/v1/appointment" data-csrf="$SecurityID" data-template="appointmentListTemplate">Appointments</a></li>
    </ul>
</div>
<% end_if %>
<% end_with %>
<div id="hd-ajaxed-content">

</div>

 <div class="member-tile columns">
    <div class="member-tile__portrait column is-auto-width<% if $Agency %> agency-base<% end_if %>">
        <% if $Member %>
            <% if $Agency %>
                <% if $Agency.Logo %>
                    $Agency.Logo.Cropped.FillMax(75,75)
                <% else %>
                    <img src="/themes/default/images/default-portrait.png" width="75" height="75" />
                <% end_if %>
            <% end_if %>
            <% if $Member.Portrait.Image %>
                <% with $Member.Portrait.Image.Cropped.FillMax(75,75) %>
                    <img src="$URL" width="$Width" height="$Height" class="member-self" />
                <% end_with %>
            <% else %>
                <img src="/themes/default/images/default-portrait.png"  class="member-self" width="75" height="75" />
            <% end_if %>
        <% else %>
            <img src="/themes/default/images/default-portrait.png" width="75" height="75" />
        <% end_if %>
    </div>
    <div class="member-tile__details column">
        <div class="member-tile__details__name">
            <% if $Agency %>
                <h2 class="title is-3 is-bold">$Agency.Title</h2>
                <p class="subtitle is-5"><em>$Member.DisplayName</em></p>
            <% else %>
                <h2 class="title is-3 is-bold">$Member.Title</h2>
            <% end_if %>
        </div>
        <% if $Member.DisplayPhonenumber %>
        <div class="member-tile__details__phonenumber">
            <% if $Agency %>
                $Agency.ContactNumber
            <% else %>
                $Member.ContactNumber
            <% end_if %>
        </div>
        <% end_if %>
        <div class="ratings">
            <% if $Rating %>
                <% with $Rating %>
                    <ul class="rating<% if $Rated %> rated<% end_if %>" data-sid="$SecurityID" data-type="PropertyPage" data-id="$Top.ID">
                        $HTML
                    </ul>
                    <span class="rating-count">($Count rating<% if $Count > 1 %>s<% end_if %>)</span>
                <% end_with %>
            <% else %>
                <% with $Member.Rating %>
                    <ul class="rating<% if $Rated %> rated<% end_if %>" data-sid="$SecurityID" data-type="Member" data-id="$Up.ID">
                        $HTML
                    </ul>
                    <span class="rating-count">($Count rating<% if $Count > 1 %>s<% end_if %>)</span>
                <% end_with %>
            <% end_if %>
        </div>
        <% if $CurrentMember %>
            <a href="#" id="btn-contact-form" class="blue-button">Contact</a>
        <% else %>
            <a href="/signin?BackURL=<% if $Top.fullURL %>$Top.fullURL<% else %>$Top.Link<% end_if %>" class="blue-button">Sign in to contact</a>
        <% end_if %>
    </div>
</div>
<div id="contact-form-holder" class="message is-info hide">
    <div class="message-header">
        <p>Express your interest</p>
        <button class="delete"></button>
    </div>
    <div class="message-body">
        $ContactForm
        <p class="loading-message hide">Submitting...</p>
        <div class="columns hide">
            <div class="column"><p class="postback-message"></p></div>
            <div class="column is-auto-width">
                <a href="#" class="button inline close-this">OK</a>
            </div>
        </div>
    </div>
</div>

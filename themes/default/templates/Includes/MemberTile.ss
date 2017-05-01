 <div class="member-tile columns">
    <div class="member-tile__portrait column is-auto-width">
        <% if $Member %>
            <% if $Member.Portrait %>
                $Member.Portrait.Image.Cropped.FillMax(75,75)
            <% end_if %>
        <% end_if %>
    </div>
    <div class="member-tile__details column">
        <div class="member-tile__details__name">
            <% if $Member.Nickname && $Member.NameToUse == 'Nickname' %>
                $Member.Nickname
            <% else %>
                $Member.FirstName<% if  $Member.Surname %> $Member.Surname<% end_if %>
            <% end_if %>
        </div>
        <% if $Member.DisplayPhonenumber %>
        <div class="member-tile__details__phonenumber">
            $Member.ContactNumber
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
                <%-- <ul class="rating" data-sid="$SecurityID" data-type="Member" data-id="$Member.ID">
                    $Member.getRating(1)
                </ul> --%>
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
            <a href="/signin?BackURL=$Top.Link" class="blue-button">Sign in to contact</a>
        <% end_if %>
    </div>
</div>
$ContactForm

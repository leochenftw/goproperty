 <div class="member-tile as-flex wrap">
    <div class="member-tile__portrait">
        <% if $Member %>
            <% if $Member.Portrait %>
                $Member.Portrait.Image.Cropped.FillMax(75,75)
            <% end_if %>
        <% end_if %>
    </div>
    <div class="member-tile__details">
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
        <ul class="rating" data-sid="$SecurityID" data-uid="$Member.ID">
            $Member.getRating(1)
        </ul>
        <% if $CurrentMember %>
            <a href="#" id="btn-contact-form" class="blue-button">Contact</a>
        <% else %>
            <a href="/signin?BackURL=$Top.Link" class="blue-button">Sign in to contact</a>
        <% end_if %>
    </div>
</div>
$ContactForm

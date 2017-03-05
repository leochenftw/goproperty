 <div class="member-tile as-flex wrap">
    <div class="member-tile__portrait">
        <% if $Member %>
            <% if $Member.Portrait %>
                $Member.Portrait.Image.Cropped.FillMax(75,75)
            <% end_if %>
        <% end_if %>
    </div>
    <div class="member-tile__details">
        <div class="member-tile__details__name">$Member.FirstName<% if  $Member.Surname %> $Member.Surname<% end_if %></div>
        <ul class="rating">
            $Member.getRating(1)
        </ul>
        <a href="mailto:$Member.Email" class="blue-button">Contact</a>
    </div>
</div>

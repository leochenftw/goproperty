<nav id="top_side_menu">
    <a href="/member" class="icon-<% if $CurrentMember %>dashboard<% else %>login<% end_if %> <% if LinkOrCurrent = current || $LinkOrSection = section %>current<% end_if %>"><% if $CurrentMember %>Dashboard<% else %>Sign in<% end_if %></a>
</nav>

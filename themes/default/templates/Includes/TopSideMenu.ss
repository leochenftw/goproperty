<nav id="top_side_menu">
    <a href="/member" class="icon-<% if $CurrentMember %>dashboard<% else %>login<% end_if %> <% if LinkOrCurrent = current || $LinkOrSection = section %>current<% end_if %>"><% if $CurrentMember %><span class="icon"><i class="fa fa-dashboard"></i></span><span>Dashboard</span><% else %><span class="icon"><i class="fa fa-sign-in"></i></span><span>Sign in</span><% end_if %></a>
</nav>

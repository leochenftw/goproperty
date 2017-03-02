<footer id="footer" class="footer">
    <div class="container as-flex wrap space-between">
        <% if $MenuSet('Footer First-Menu').MenuItems.Count > 0 %>
            <div class="footer__col first">
                <ul>
                <% loop $MenuSet('Footer First-Menu').MenuItems %>
                    <li><a href="$Link" class="$LinkingMode">$MenuTitle</a></li>
                <% end_loop %>
                </ul>
            </div>
        <% end_if %>
        <% if $MenuSet('Footer Second-Menu').MenuItems.Count > 0 %>
            <div class="footer__col second">
                <ul>
                <% loop $MenuSet('Footer Second-Menu').MenuItems %>
                    <li><a href="$Link" class="$LinkingMode">$MenuTitle</a></li>
                <% end_loop %>
                </ul>
            </div>
        <% end_if %>
        <% if $MenuSet('Footer Social-Menu').MenuItems.Count > 0 %>
            <div class="footer__col social">
                <div class="footer__col__logo-holder">
                    <a href="$Top.baseURL">$Top.SiteConfig.Title</a>
                </div>
                <ul>
                <% loop $MenuSet('Footer Social-Menu').MenuItems %>
                    <li><a href="$Link"<% if $IsNewWindow %> target="_blank"<% end_if %> class="$LinkingMode icon-$MenuTitle.LowerCase">$MenuTitle</a></li>
                <% end_loop %>
                </ul>
            </div>
        <% end_if %>
    </div>
</footer>

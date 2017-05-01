<footer id="footer" class="footer">
    <div class="container">
        <div class="columns is-marginless">
            <% if $MenuSet('Footer First-Menu').MenuItems.Count > 0 %>
                <div class="footer__col first column">
                    <ul>
                    <% loop $MenuSet('Footer First-Menu').MenuItems %>
                        <li><a href="$Link" class="$LinkingMode">$MenuTitle</a></li>
                    <% end_loop %>
                    </ul>
                </div>
            <% end_if %>
            <% if $MenuSet('Footer Second-Menu').MenuItems.Count > 0 %>
                <div class="footer__col second column">
                    <ul>
                    <% loop $MenuSet('Footer Second-Menu').MenuItems %>
                        <li><a href="$Link" class="$LinkingMode">$MenuTitle</a></li>
                    <% end_loop %>
                    </ul>
                </div>
            <% end_if %>
            <% if $MenuSet('Footer Social-Menu').MenuItems.Count > 0 %>
                <div class="footer__col social column">
                    <div class="footer__col__logo-holder">
                        <a href="$Top.baseURL">$Top.SiteConfig.Title</a>
                    </div>
                    <ul>
                    <% loop $MenuSet('Footer Social-Menu').MenuItems %>
                        <li><a href="$Link"<% if $IsNewWindow %> target="_blank"<% end_if %> class="$LinkingMode icon"><i class="fa fa-$MenuTitle.LowerCase"></i><span class="hide">$MenuTitle</span></a></li>
                    <% end_loop %>
                    </ul>
                </div>
            <% end_if %>
        </div>
    </div>
</footer>

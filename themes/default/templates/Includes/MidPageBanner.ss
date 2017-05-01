<div class="mid-page-banner">
    <div class="container">
        <dvi class="columns is-marginless">
            <% if $Label %>
                <h2 class="column is-auto-width mid-page-banner__title">$Label</h2>
            <% end_if %>
            <div class="column is-auto-width">
                <% if $CurrentMember %>
                    <a href="/member" class="blue-button mid-page-banner__button">Dashboard</a>
                <% else %>
                    <a href="/signup" class="blue-button mid-page-banner__button">Sign up</a>
                <% end_if %>
            </div>
        </div>
    </div>
</div>

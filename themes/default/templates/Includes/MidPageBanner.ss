<div class="mid-page-banner">
    <div class="container as-flex wrap horizontal-centred vertical-centred">
        <% if $Label %>
            <h2 class="mid-page-banner__title">$Label</h2>
        <% end_if %>
        <% if $CurrentMember %>
            <a href="/member" class="blue-button mid-page-banner__button">Dashboard</a>
        <% else %>
            <a href="/signup" class="blue-button mid-page-banner__button">Sign up</a>
        <% end_if %>
    </div>
</div>

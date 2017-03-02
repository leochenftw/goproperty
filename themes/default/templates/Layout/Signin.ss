<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<div class="section signin-form-wrapper">
    <div class="container">
        <% with $SigninForm %>
            <% if $Message %>
            <div class="message-wrapper $Message.MessageType">$Message</div>
            <% end_if %>
            <form $FormAttributes>
                <div class="fields">
                    $Fields
                    $Actions.Last
                </div>
                <div class="Actions">
                    $Actions.First
                </div>
                <div class="lnk-signup-wrapper margin-h-10-0-0 text-center"><a href="/signup">Sign up</a></div>
            </form>
            $clearMessage
        <% end_with %>
    </div>
</div>

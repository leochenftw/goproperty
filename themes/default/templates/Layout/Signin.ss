<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<div class="section signin-form-wrapper">
    <div class="container">
        <h1 class="title is-2 has-text-centered">Sign in</h1>
        <% with $SigninForm %>
            <% if $Message %>
            <div class="message-wrapper has-text-centered $Message.MessageType">$Message</div>
            <% end_if %>
            <form $FormAttributes>
                <div class="fields">
                    $Fields
                    <%-- $Actions.Last --%>
                    <p id="ForgotPassword"><a href="/Security/lostpassword">Forgotten my password</a></p>
                </div>
                <div class="Actions">
                    $Actions.First
                </div>
                <div class="lnk-signup-wrapper margin-h-10-0-0 text-center"><a href="/signup<% if $Top.BackURL %>?BackURL=$Top.BackURL<% end_if %>">Sign up</a></div>
            </form>
            $clearMessage
        <% end_with %>
    </div>
</div>

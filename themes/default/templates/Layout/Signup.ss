<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<div class="section signup-form-wrapper">
    <div class="container">
        <% with $SignupForm %>
            <% if $Message %>
            <div class="message-wrapper $Message.MessageType">$Message</div>
            <% end_if %>
            <form $FormAttributes>
                <div class="fields">
                    <% loop $Fields %>
                        $FieldHolder
                        <% if $Name == 'SignupToBe' %>
                        <p>Upgrade account type(s) should you need to</p>
                        <ul id="account-types" class="account-types">
                            <li data-price="$Up.getSubscription('Landlords')" data-target="SignupForm_SignupForm_SignupToBe_beLandlords">
                                <h4>Landlord</h4>
                                <p>You can list properties for rent.</p>
                                <p>${$Up.getSubscription('Landlords')} per month</p>
                            </li>
                            <li data-price="$Up.getSubscription('Realtors')" data-target="SignupForm_SignupForm_SignupToBe_beRealtors">
                                <h4>Realtor</h4>
                                <p>You can list properties for rent and for sale.</p>
                                <p>${$Up.getSubscription('Realtors')} per month</p>
                            </li>
                            <li data-price="$Up.getSubscription('Tradesmen')" data-target="SignupForm_SignupForm_SignupToBe_beTradesmen">
                                <h4>Tradesperson</h4>
                                <p>You can list your business and services, and take job from the public.</p>
                                <p>${$Up.getSubscription('Tradesmen')} per month</p>
                            </li>
                        </ul>
                        <p>Amount due: <strong id="amount-due">$0.00</strong><br /><em>Please note, you won't get charged straightaway, until you activate your account.</em></p>
                        <% end_if %>
                    <% end_loop %>
                </div>

                <div class="Actions">
                    $Actions
                </div>
                <div class="lnk-signup-wrapper margin-h-10-0-0 text-center"><a href="/signin?backURL=/member">Sign in</a></div>
            </form>
            $clearMessage
        <% end_with %>
    </div>
</div>

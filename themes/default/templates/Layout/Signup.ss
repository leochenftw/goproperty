<% include GooglemapsHero Lat=-41.1093769, Lng=174.88356010000007 %>
<div class="section signup-form-wrapper">
    <div class="container">
        <h1 class="hide">Sign up</h1>
        <div class="columns">
            <% if $PromoSeason %>
                <div class="column" style="border-right: 1px solid #ccc;">
                    <h2 class="title is-3 has-text-centered">PROMOTION!</h2>
                    <div class="columns is-marginless">
                        <div class="column content">
                            <p class="title is-4">The promo season is upon us! You feel like to add some content?</p>
                            <p><strong>This is how it works:</strong></p>
                            <p>During the promo season, this side of the page will show up, which gives the users the idea what this is about. So, if the users sign up during the promo season, their accounts will be <strong>automatically</strong> granted with 28 days free trial.</p>
                        </div>
                    </div>
                </div>
            <% end_if %>
            <div class="column">
                <h2 class="title is-3 has-text-centered">CREATE YOUR ACCOUNT</h2>
                <% with $SignupForm %>
                    <% if $Message %>
                    <div class="notification $MessageType">$Message</div>
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
    </div>
</div>

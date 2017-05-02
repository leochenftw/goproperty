<h2 class="title">Account fees</h2>
<div class="content">
    <% if $CurrentMember.NeedsToPay %>
        <p>Please proceed the payment, and finalise your account activation.</p>
    <% else %>
        <p>Want to empower your account to do more? Choose from below account types.</p>
    <% end_if %>
    <% if $CurrentMember.isLandlord || $CurrentMember.isRealtor || $CurrentMember.isTradesperson %>
    <div class="already">
        <h3>Types subscribed</h3>
        <% include UserAccountTypes %>
    </div>
    <% end_if %>
</div>
<div class="about-to content">
    <% if not $CurrentMember.beLandlords && not $CurrentMember.beTradesmen && not $CurrentMember.beRealtors %>
    <h3>Available types</h3>
    <% end_if %>
    <ul id="account-types" class="account-types">
        <% if not $CurrentMember.inGroup('landlords') %>
            <li class="icon" data-price="$AccountUpgradeForm.getSubscription('Landlords')" data-target="AccountUpgradeForm_AccountUpgradeForm_AccountType_Landlords">
                <h4 class="title is-4">Landlord</h4>
                <p>You can list properties for rent.</p>
                <p>${$AccountUpgradeForm.getSubscription('Landlords')} per month</p>
            </li>
        <% end_if %>
        <% if not $CurrentMember.inGroup('realtors') %>
            <li class="icon" data-price="$AccountUpgradeForm.getSubscription('Realtors')" data-target="AccountUpgradeForm_AccountUpgradeForm_AccountType_Realtors">
                <h4 class="title is-4">Realtor</h4>
                <p>You can list properties for rent and for sale.</p>
                <p>${$AccountUpgradeForm.getSubscription('Realtors')} per month</p>
            </li>
        <% end_if %>
        <% if not $CurrentMember.inGroup('tradesmen') %>
            <li class="icon" data-price="$AccountUpgradeForm.getSubscription('Tradesmen')" data-target="AccountUpgradeForm_AccountUpgradeForm_AccountType_Tradesmen">
                <h4 class="title is-4">Tradesperson</h4>
                <p>You can list your business and services, and take job from the public.</p>
                <p>${$AccountUpgradeForm.getSubscription('Tradesmen')} per month</p>
            </li>
        <% end_if %>
    </ul>
</div>
<div class="content">
    <p>Amount due: <strong id="amount-due">$0.00</strong></p>
</div>
$AccountUpgradeForm

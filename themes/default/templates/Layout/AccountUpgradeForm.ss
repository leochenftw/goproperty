<h2 class="title">Account fees</h2>

<% if $canUseVoucher %>
    <div class="content">
        <h3 class="title is-4">Redeem your voucher</h3>
        <p>Redeem your voucher, get 28 days free trial.</p>
        $VoucherForm
    </div>
<% else %>
    <div class="content">
        <% if not $CurrentMember.TrialExpired %>
            <h3 class="title is-4">Free trial enabled</h3>
            <p>You are covered by 28 days <strong>Free Trial</strong> voucher. You may now use all paid services for free.<br />
            You free trial ends on: <strong>$CurrentMember.FreeUntil.Nice</strong></p>
        <% else %>
            <h3 class="title is-4">Free trial expired</h3>
            <p>You free trial ended on: <strong>$CurrentMember.FreeUntil.Nice</strong><br />
            You may only redeem 2-month free voucher once.</p>
        <% end_if %>
    </div>
<% end_if %>

<div class="content">
    <% if $CurrentMember.isLandlord || $CurrentMember.isRealtor || $CurrentMember.isTradesperson %>
    <div class="already">
        <h3>Types subscribed</h3>
        <% include UserAccountTypes %>
    </div>
    <% end_if %>
</div>
<% if not $CurrentMember.inGroup('landlords') || not $CurrentMember.inGroup('realtors') || not $CurrentMember.inGroup('tradesmen') || not $CurrentMember.inGroup('testa') || not $CurrentMember.inGroup('testb') %>
    <div class="about-to content">
        <h3>Available types</h3>
        <p>Want to empower your account to do more? Choose from below account types.</p>
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
        <% if not $CurrentMember.TrialExpired %>
            <p><strong>FREE TO GO</strong></p>
        <% else %>
            <p>Amount due: <strong id="amount-due">$0.00</strong></p>
        <% end_if %>
    </div>
    $AccountUpgradeForm
<% end_if %>

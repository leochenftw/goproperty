<h2 class="title is-3 is-bold">Payment history</h2>
<% if $CurrentMember.PaymentHistory %>
<div class="transactions">
    <%-- <table class="as-table full-width">
        <thead>
            <tr>
                <th>Status</th>
                <th>Transaction ID</th>
                <th>Paid at</th>
                <th>Amount paid</th>
                <th>Detail</th>
            </tr>
        </thead>
        <tbody>
        <% loop $CurrentMember.PaymentHistory %>
            <tr>
                <td>$Payments.First.Status</td>
                <td><% if $Payments.First.TransacID %>$Payments.First.TransacID<% else %>-<% end_if %></td>
                <td>$LastEdited</td>
                <td>${$Payments.First.Amount.Amount}</td>
                <td>$PaidFor</td>
            </tr>
        <% end_loop %>
        </tbody>
    </table> --%>

    <div class="columns is-heading is-hidden-mobile">
        <div class="column is-1">Status</div>
        <div class="column is-2">Transaction ID</div>
        <div class="column is-3">Paid at</div>
        <div class="column is-2">Amount</div>
        <div class="column">Detail</div>
    </div>
    <div class="is-body">
    <% loop $CurrentMember.PaymentHistory %>
        <div class="columns is-body-row">
            <div class="column is-1"><strong class="is-hidden-desktop-only is-hidden-widescreen is-hidden-tablet-only">Status:</strong> $Payments.First.Status</div>
            <div class="column is-2"><strong class="is-hidden-desktop-only is-hidden-widescreen is-hidden-tablet-only">Transaction ID:</strong> <% if $Payments.First.TransacID %>$Payments.First.TransacID<% else %>-<% end_if %></div>
            <div class="column is-3"><strong class="is-hidden-desktop-only is-hidden-widescreen is-hidden-tablet-only">Paid at:</strong> $LastEdited</div>
            <div class="column is-2"><strong class="is-hidden-desktop-only is-hidden-widescreen is-hidden-tablet-only">Detail:</strong> ${$Payments.First.Amount.Amount}</div>
            <div class="column">$PaidFor</div>
        </div>
    <% end_loop %>
    </div>
</div>
<% else %>
    <p><em>-- no record --</em></p>
<% end_if %>

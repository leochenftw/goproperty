<h2 class="title">Payment history</h2>
<% loop $PaymentHistory %>
    $TransacID<br />
    $Status<br />
    $ProcessedAt<br />
    ${$Amount.Amount}<br />
    $PaidFor
<% end_loop %>

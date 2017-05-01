<h2 class="title is-3 is-bold">Payment history</h2>
<% if $CurrentMember.PaymentHistory %>
    <table class="as-table full-width">
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
    </table>
<% else %>
    <p><em>-- no record --</em></p>
<% end_if %>

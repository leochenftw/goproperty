<h2 class="title">Payment history</h2>
<table class="as-table full-width">
    <tbody>
    <% loop $PaymentHistory %>
        <tr>
            <td>$Status</td>
            <td><% if $TransacID %>$TransacID<% else %>-<% end_if %></td>
            <td>$ProcessedAt</td>
            <td>${$Amount.Amount}</td>
            <td>$PaidFor</td>
        </tr>
    <% end_loop %>
    </tbody>
</table>

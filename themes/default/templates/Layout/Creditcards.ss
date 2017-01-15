<h2 class="title">Manage saved creditcards</h2>
$addCreditcardForm
<table class="as-table full-width creditcards">
    <tbody>
    <% loop $Creditcards %>
        <tr>
            <td><% if $isPrimary %><span class="icon-primary">Primary</span><% end_if %></td>
            <td><span class="icon-{$CardType}">$CardType</span></td>
            <td>$CardNumber</td>
            <td>{$Month}/{$Year}</td>
            <td>
                <form class="mini-form" method="DELETE" action="/api/v1/creditcard/$ID"><button type="submit">Delete</button></form>
            </td>
        </tr>
    <% end_loop %>
    </tbody>
</table>

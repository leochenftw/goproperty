<h2 class="title">My subscription</h2>
<h3>Tradesman account subscription</h3>
<% if $Subscription %>
    <% with $Subscription %>
        Subscription charge: ${$Amount.Amount} <br />
        Next bill date: $NextPayDate <br />
        <form class="mini-ajax-form" method="POST" action="/api/v1/payment/$ID">
            <input type="hidden" name="SecurityID" value="$SecurityID" />
            <button type="submit">Cancel</button>
        </form>
    <% end_with %>
<% else_if $ActiveSubscription %>
    <% with $ActiveSubscription %>
        <p>There is no further payment scheduled for your account. Your current subscription ends of $ValidUntil</p>
    <% end_with %>
<% else %>
    <p>You have no subscription</p>
<% end_if %>

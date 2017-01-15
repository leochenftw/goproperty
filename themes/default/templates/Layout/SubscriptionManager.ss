<h2 class="title">Cancel subscription</h2>
<% with $Subscription %>
    <h3>Tradesman account subscription</h3>
    Subscription charge: ${$Amount.Amount} <br />
    Next bill date: $NextPayDate <br />
    <a href="/api/v1/payment/$ID" target="_blank">cancel</a>
<% end_with %>

<% with $Coodinates %>
<% include GooglemapsHero Lat=$Lat, Lng=$Lng %>
<% end_with %>
<div class="container form-container">
    <% if $FeedbackForm.Message && $FeedbackForm.MessageType == 'is-success' %>
    <div class="columns"><div class="notification has-text-centered $FeedbackForm.MessageType is-offset-one-quarter">$FeedbackForm.Message</div></div>
    <% else %>
        <div class="columns">
            <div class="column is-half is-offset-one-quarter">
                <h2 class="title is-5 is-bold">YOUR FEEDBACK TO</h2>
                <p>$FeedbackTo</p>
            </div>
        </div>
        <div class="columns">
            <% if $FeedbackForm %>
                <% with $FeedbackForm %>
                    <form $FormAttributes>
                        <div class="fields">
                            <% loop $Fields %>
                                <% if $Name == 'Stars' %>
                                <div class="columns vertical-bottom">
                                    <div class="column is-8">$FieldHolder</div>
                                    <div class="column is-4">
                                        <ul class="rating has-text-right">
                                            <li data-stars="1" class="icon"><i class="fa fa-star-o"></i></li>
                                            <li data-stars="2" class="icon"><i class="fa fa-star-o"></i></li>
                                            <li data-stars="3" class="icon"><i class="fa fa-star-o"></i></li>
                                            <li data-stars="4" class="icon"><i class="fa fa-star-o"></i></li>
                                            <li data-stars="5" class="icon"><i class="fa fa-star-o"></i></li>
                                        </ul>
                                    </div>
                                </div>
                                <% else %>
                                $FieldHolder
                                <% end_if %>
                            <% end_loop %>
                        </div>
                        <div class="Actions">
                            $Actions
                        </div>
                    </form>
                <% end_with %>
            <% else %>
                <div class="column is-half is-offset-one-quarter">
                <% if $FeedbackMessage %>
                    $FeedbackMessage
                <% else %>
                    You just open a feedback ticket that you have previously rated.
                <% end_if %>
                </div>
            <% end_if %>
        </div>
    <% end_if %>
    $flushMessage
</div>

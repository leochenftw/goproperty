var memberTestimonialTemplate   =
'<div id="member-testimonial-viewer" class="message is-info overlay-element">\
    <div class="message-header">\
        <p>Testimonials</p>\
        <button class="delete"></button>\
    </div>\
    <div class="message-body">\
        {{#if @root}}\
        {{#each @root}}\
        <div class="columns interest-item">\
            <div class="portrait column is-auto-width">\
                <img src="{{portrait}}" />\
            </div>\
            <div class="details column">\
                <h3 class="title is-4 is-bold is-marginless"><span class="name">{{By}}</span> <span class="email">{{Date}}</span></h3>\
                <ul class="is-4 ratings is-marginless">{{{Stars}}}</ul>\
                <div class="content">{{#if Comment}}{{Comment}}{{else}}- no comment -{{/if}}</div>\
            </div>\
        </div>\
        {{/each}}\
        {{else}}\
        <p>no testimonial history</p>\
        {{/if}}\
    </div>\
</div>';

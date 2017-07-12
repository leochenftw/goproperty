var serviceRequesterTemplate =
'{{#if @root}}\
{{#each @root}}\
    <div class="columns interest-item">\
        <div class="portrait column is-2"><img src="{{member.portrait}}" /></div>\
        <div class="details column">\
            <h3 class="title is-4 is-bold is-marginless"><span class="name">{{member.name}}</span> <span class="email" style="font-style: italic; font-size: 14px;">({{member.email}})</span></h3>\
            <div class="columns vertical-center is-marginless-vertical">\
                <div class="column is-narrow"><ul class="is-4 ratings is-marginless">{{{member.rating}}}</ul></div>\
            </div>\
            <div class="content">{{message}}</div>\
            <div class="actions"></div>\
        </div>\
    </div>\
{{/each}}\
{{else}}\
    <p>no testimonial history</p>\
{{/if}}';

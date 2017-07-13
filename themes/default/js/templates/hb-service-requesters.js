var serviceRequesterTemplate =
'{{#if @root}}\
{{#each @root}}\
    <div class="columns interest-item{{#if fold}} fold{{/if}}" data-foldable="{{fold}}">\
        <div class="portrait column is-narrow"><img src="{{member.portrait}}" /></div>\
        <div class="details column">\
            <h3 class="title is-4 is-bold is-marginless"><span class="name">{{member.name}}</span> <span class="email" style="font-style: italic; font-size: 14px;">({{member.email}})</span></h3>\
            <div class="columns vertical-center is-marginless-vertical misc">\
                <div class="column is-narrow"><ul class="is-4 ratings is-marginless">{{{member.rating}}}</ul></div>\
            </div>\
            <div class="content">{{message}}</div>\
            <div class="actions is-relative">\
                <button class="button inline red" data-endpoint="/api/v1/service-request/{{id}}/read" data-sid="{{token}}">Ignore</button>\
                <a class="button inline yellow" href="mailto:{{member.email}}">Contact</a>\
                <button class="button inline green" style="color: rgba(0, 0, 0, 0.7);" data-sid="{{token}}" data-endpoint="/api/v1/service-request/{{id}}/accept">Create appointment</button>\
            </div>\
        </div>\
    </div>\
{{/each}}\
{{else}}\
    <p>- no request so far -</p>\
{{/if}}';

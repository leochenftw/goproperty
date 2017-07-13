var appointmentListTemplate =
'{{#if @root}}\
{{#each @root}}\
<div class="columns appointment-item">\
    <div class="column is-narrow">\
        <a title="click to view on Google maps" href="https://www.google.com/maps/place/{{Address}}/@{{Lat}},{{Lng}},12z" target="_blank">\
            <img width="135" height="135" src="https://maps.googleapis.com/maps/api/staticmap?center={{Lat}},{{Lng}}&zoom=12&size=135x135&markers=color:red%7Clabel:S%7C{{Lat}},{{Lng}}&key={{GKey}}" /></div>\
        </a>\
    <div class="column">\
        <h3 class="title is-5 is-bold">{{Address}}</h3>\
        <p class="subtitle is-6 align-vertical-center"><span>Requested by:</span> <img style="width: auto; height: 16px; margin: 0 0.25em;" src="{{Portrait}}" alt="{{Client}} "/> <span>{{Client}}</span></p>\
        <div class="content">\
            <form class="appointment-dt-form" method="post" action="/api/v1/appointment/{{ID}}/set-date">\
                <div class="display {{#unless Date}}hide{{/unless}}">\
                    <p class="date is-marginless">Appointment at: {{#if Date}}{{Date}}{{/if}}</p>\
                    <p class="memo">\
                    {{#if Memo}}\
                    Memo: {{Memo}}\
                    {{else}}\
                    - no memo -\
                    {{/if}}\
                    </p>\
                </div>\
                <div class="editor columns is-marginless-vertical{{#if Date}} hide{{/if}}">\
                    <div class="column is-paddingless-vertical">\
                        <div class="field" style="margin-bottom: 10px;">\
                            <input placeholder="click to pick a date" type="text" class="text dt-picker input" name="Date"{{#if Date}} value="{{Date}}"{{/if}} />\
                        </div>\
                        <div class="field">\
                            <textarea placeholder="type to leave a memo" name="Memo" class="textarea">{{#if Memo}}{{Memo}}{{/if}}</textarea>\
                            <em class="description">This memo will be emailed to the other party too.</em>\
                        </div>\
                    </div>\
                    <div class="column is-paddingless">\
                        <button class="button inline" type="submit"><span class="icon"><i class="fa fa-check"></i></span></button>\
                        {{#if Date}}<a href="#" class="button inline red btn-cancel"><span class="icon"><i class="fa fa-times"></i></span></a href="#">{{/if}}\
                    </div>\
                </div>\
                <input type="hidden" name="SecurityID" value="{{CSRF}}" />\
            </form>\
        </div>\
    </div>\
</div>\
{{/each}}\
{{else}}\
<p>- no appoint so far -</p>\
{{/if}}';

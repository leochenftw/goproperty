var InterestItem = function(data, canAccept)
{
    this.template = '<div class="columns interest-item">\
                        <div class="portrait column is-auto-width"><img src="" /></div>\
                        <div class="details column">\
                            <h3 class="title is-4 is-bold is-marginless"><span class="name"></span> <span class="email"></span></h3>\
                            <div class="columns vertical-center is-marginless-vertical misc">\
                                <div class="column is-narrow"><ul class="is-4 ratings is-marginless"></ul></div>\
                                <div class="column is-paddingless"><a class="history-viewer button inline" href="">view history</a></div>\
                            </div>\
                            <div class="content"></div>\
                            <div class="actions"></div>\
                        </div>\
                    </div>';

    var theHTML = this.html = $(this.template);
    if (data.fold) {
        this.html.addClass('fold').attr('data-foldable', 1);
    }
    this.html.find('img').attr('src', data.member.portrait);
    this.html.find('.title .name').html(data.member.name);
    this.html.find('.title .email').html('(' + data.member.email + ')');
    this.html.find('.ratings').html(data.member.rating);
    this.html.find('.content').html(data.message);
    this.html.find('.history-viewer').attr('href', '/api/v1/rating/Member/' + data.member.id);

    var btnReject   =   $('<button />').addClass('button inline red').attr('data-sid', data.token).attr('data-id', data.id).html('Ignore'),
        btnContact  =   $('<a />').addClass('button inline yellow').attr('href', 'mailto:' + data.member.email).html('Contact'),
        btnAccept   =   $('<button />').addClass('button inline green').html('Accept');

    this.html.find('.title').click(function(e)
    {
        e.preventDefault();
        if (theHTML.data('foldable') == 1) {
            theHTML.toggleClass('fold');
        }
    });

    this.html.find('.history-viewer').click(function(e)
    {
        e.preventDefault();
        $(this).addClass('is-loading');
        var endpoint    =   $(this).attr('href'),
            me          =   $(this);
        $.get(
            endpoint,
            function(data)
            {
                me.removeClass('is-loading');
                $('#interest-list').addClass('sunken');
                var template    =   Handlebars.compile(memberTestimonialTemplate),
                    popup       =   template(data);

                $('body').append(popup);

                $('#member-testimonial-viewer').find('.delete').click(function(e)
                {
                    e.preventDefault();
                    $('#member-testimonial-viewer').remove();
                    $('#interest-list').removeClass('sunken');
                });
            }
        );
    });

    btnReject.click(function(e)
    {
        e.preventDefault();
        if (theHTML.data('foldable') == 1) {
            theHTML.addClass('fold');
            return;
        }

        var sid             =   $(this).data('sid'),
            interestID      =   $(this).data('id');

        $.post(
            '/api/v1/eoi/' + interestID + '/read',
            {
                SecurityID: sid
            },
            function(data)
            {
                if (data === true) {
                    theHTML.addClass('fold').attr('data-foldable', 1);
                }
            }
        );
    });

    btnAccept.click(function(e)
    {
        e.preventDefault();
        var rentalForm = new RentalForm(data);
        $('#interest-list').addClass('sunken');
        $('body').append(rentalForm);
    });

    this.html.find('.actions').append(btnReject, btnContact);
    if (canAccept) {
        this.html.find('.actions').append(btnAccept);
    }

    return this.html;
};

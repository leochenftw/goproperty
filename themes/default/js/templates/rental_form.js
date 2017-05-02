var RentalForm = function(data)
{
    this.template = '<div id="rental-setup-form" class="message is-success overlay-element">\
                        <div class="message-header">\
                            <p>Renting to <em><strong class="name"></strong></em>...</p>\
                            <button class="delete"></button>\
                        </div>\
                        <div class="message-body">\
                            <form method="POST">\
                                <div class="columns">\
                                    <div class="column">\
                                        <label for="date-start">Start date</label>\
                                        <input id="date-start" type="text" class="text" name="Start" />\
                                    </div>\
                                    <div class="column">\
                                        <label for="date-end">End date</label>\
                                        <input id="date-end" type="text" class="text" name="End" />\
                                    </div>\
                                </div>\
                                <input id="rental-security-id" name="SecurityID" type="hidden" value="" />\
                                <div class="actions columns vertical-center">\
                                    <div class="column">\
                                        <label for="use-notice"><input id="use-notice" type="checkbox" class="checkbox" name="UseNotice" checked /> Remind me for inspection</label>\
                                    </div>\
                                    <div class="column">\
                                        <button type="submit" class="button">Submit</button>\
                                    </div>\
                                </div>\
                            </form>\
                        </div>\
                    </div>';

    var theHTML = this.html = $(this.template);

    this.html.find('.name').html(data.member.name);

    this.html.find('form').attr('action', '/api/v1/eoi/' + data.id + '/accept').submit(function(e)
    {
        e.preventDefault();
        var theForm =   $(this),
            url     =   $(this).attr('action'),
            params  =   {
                            SecurityID: data.token,
                            UseNotice: theForm.find('#use-notice').prop('checked') ? 1 : 0
                        };

        $(this).find('.text').each(function(i, el)
        {
            params[$(this).attr('name')] = $(this).val();
        });

        $(this).find('button[type="submit"]').addClass('is-loading');
        $(this).find('.text, .checkbox').prop('disabled', true);
        theHTML.find('button.delete').remove();
        $.post(
            url,
            params,
            function(response)
            {
                if (response == true)
                {
                    var btnOK = $('<a href="#" class="button">OK</a>');
                    theHTML.find('.message-body').addClass('content').html('<p class="has-text-centered">Rental record setup complete!</p><div class="has-text-centered ok-container"></div>');
                    theHTML.find('.message-body .ok-container').append(btnOK);

                    btnOK.click(function(e)
                    {
                        e.preventDefault();
                        theHTML.remove();
                        $('#interest-list').remove();
                        $('body').removeClass('overlayed');
                        $('html').removeClass('locked');
                    });
                }
            }
        );

    });

    this.html.find('button.delete').click(function(e)
    {
        e.preventDefault();
        theHTML.remove();
        $('#interest-list').removeClass('sunken');
    });

    this.html.find('#date-start, #date-end').datetimepicker(
    {
        timepicker: false,
        format: 'd/m/Y',
        scrollInput: false,
        onSelectDate: function(ct,$i)
        {
            if ($i.is('#date-start')) {
                var endDate = new Date(ct.valueOf());
                endDate.setDate(endDate.getDate() + 365);
                var str = endDate.getDate().DoubleDigit() + '/' + (endDate.getMonth() + 1).DoubleDigit() + '/' + endDate.getFullYear();
                $("#date-end").val(str);
            }
        }
    });



    return this.html;
};

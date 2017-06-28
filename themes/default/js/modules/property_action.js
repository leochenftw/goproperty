(function($)
{
    $.fn.propertyAction = function()
    {
        var ajaxing         =   null,
            self            =   $(this);

        $(this).click(function(e)
        {
            e.preventDefault();
            if (ajaxing) {
                ajaxing.abort();
                ajaxing = null;
            }

            if ($(this).hasClass('is-active')) {
                $(this).removeClass('is-active')
                $(this).parents('.member-area__content__property-list__item__info:eq(0)').find('.forms').html('');
                return false;
            }

            $('.member-area__content__property-list__item__info__controls .btn-listing.is-active').removeClass('is-active');
            $(this).addClass('is-loading');

            var formContainer   =   $(this).parents('.member-area__content__property-list__item__info:eq(0)').find('.forms'),
                me              =   $(this),
                row             =   $(this).parents('.member-area__content__property-list__item:eq(0)');

            $('.forms').html('');
            ajaxing = $.get($(this).attr('href'), function(data)
            {
                if (typeof(data) != 'object') {
                    me.removeClass('is-loading').addClass('is-active');
                    formContainer.append(data);
                    formContainer.find('select[name="AgencyID"]').change(function(e)
                    {
                        if ($(this).val().length == 0) {
                            formContainer.find('div.agency-ref').hide();
                        } else {
                            formContainer.find('div.agency-ref').show();
                        }
                    }).change();
                    formContainer.find('input.use-dt-picker').datetimepicker(
                    {
                        timepicker: false,
                        format: 'Y-m-d',
                        scrollInput: false,
                        scrollMonth: false,
                        minDate: new Date(),
                        onSelectDate: function(ct,$i)
                        {
                            if ($i.data('daily-charge')) {
                                var dailyCharge =   $i.data('daily-charge'),
                                    toDate      =   ct.getTime(),
                                    now         =   Date.now(),
                                    diff        =   toDate - now,
                                    diff_days   =   Math.ceil(diff/1000/3600/24) + 1,
                                    output      =   $i.parents('div.field:eq(0)').find('.description');

                                output.html('Listing for ' + diff_days + (diff_days > 1 ? ' days' : ' day') + ' will cost you: ' + (diff_days * dailyCharge).toDollar());

                            }
                        }
                    });
                    formContainer.find('input[name="action_doCancel"], .do-cancel').click(function(e)
                    {
                        e.preventDefault();
                        row.find('.btn-listing.is-active').removeClass('is-active');
                        formContainer.html('');
                        $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
                    });

                    formContainer.find('input[name="ListTilGone"]').change(function(e)
                    {
                        if ($(this).is(':checked')) {
                            if ($(this).val() == 0) {
                                $('#RentalListingForm_RentalListingForm_ListTilDate_Holder').show();
                            } else {
                                $('#RentalListingForm_RentalListingForm_ListTilDate_Holder').hide();
                                $('#RentalListingForm_RentalListingForm_ListTilDate_Holder input.date').val('');
                                $('#RentalListingForm_RentalListingForm_ListTilDate_Holder span.description').html('select date to work out the cost for listing.');
                            }
                        }
                    }).change();

                    formContainer.find('a.btn-end-listing').click(function(e)
                    {
                        e.preventDefault();
                        if (confirm('You are going to end this listing. Are you sure?')) {
                            var columns = $(this).parents('.columns:eq(0)');
                            $.post(
                                $(this).attr('href'),
                                function(data)
                                {
                                    if (typeof(data) == 'object') {
                                        if (data.code == 200) {
                                            columns.find('.listing-status').html(data.message);
                                            columns.find('.actions').html('');
                                        } else {
                                            alert(data.message);
                                        }
                                    } else {
                                        alert(data);
                                    }
                                }
                            );
                        }
                    });

                    formContainer.find('a.btn-delete-listing').click(function(e)
                    {
                        e.preventDefault();
                        if (confirm('You are going to delete this listing. Are you sure?')) {
                            var columns = $(this).parents('.columns:eq(0)');
                            $.post(
                                $(this).attr('href'),
                                function(data)
                                {
                                    if (typeof(data) == 'object') {
                                        if (data.code == 200) {
                                            columns.remove();
                                            if (row.find('.all-listings .columns').length == 0) {
                                                row.find('.all-listings').html('<p>No listing</p>');
                                            }
                                        } else {
                                            alert(data.message);
                                        }
                                    } else {
                                        alert(data);
                                    }
                                }
                            );
                        }
                    });

                    formContainer.find('a.btn-listing').propertyAction();
                    ajaxForm(formContainer, me.data('expect-form'));
                } else {
                    if (data.url) {
                        location.href = data.url;
                    }
                }

                $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
            });
        });

        function ajaxForm(formContainer, expectForm)
        {
            var row             =   formContainer.parents('.member-area__content__property-list__item:eq(0)');
            if (formContainer.find('form').length > 0) {
                formContainer.find('form a:not(".do-cancel, .btn-file-browser, .photos-row a")').unbind('click').click(ajaxGet);
                formContainer.find('input[name="action_doCancel"], .do-cancel').click(function(e)
                {
                    e.preventDefault();
                    formContainer.html('');
                    formContainer.parent().find('.btn-listing.is-active').removeClass('is-active');
                    $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
                });

                formContainer.find('form .btn-file-browser').click(function(e)
                {
                    e.preventDefault();
                    var theBtn = $(this).parents('form:eq(0)').find('input[type="file"]');
                    theBtn.click();
                });

                formContainer.find('form .simple-previewable').previewable();

                formContainer.find('form').formWork().ajaxSubmit(
                {
                    onstart: function()
                    {
                        formContainer.find('form input[type="submit"]').prop('disabled', true)
                    },
                    success: function(response)
                    {
                        var isJSON = false;
                        try {
                            response = JSON.parse(response);
                            isJSON = true;
                        } catch (e) {

                        }

                        if (!isJSON) {
                            var newForm = $(response).find('form');
                            newForm.find('a:not(".do-cancel, .btn-file-browser, .photos-row a")').unbind('click').click(ajaxGet);
                            formContainer.find('form').replaceWith(newForm);
                            ajaxForm(formContainer, expectForm);
                        } else {
                            if (response.title) {
                                row.find('.title').html(response.title);
                            }

                            if (response.thumbnail && response.thumbnail.length > 0) {
                                row.find('.member-area__content__property-list__item__image img').attr('src', response.thumbnail);
                            }
                            
                            switch (response.then) {
                                case 'close_form':
                                    formContainer.html('');
                                    row.find('.btn-listing.is-active').removeClass('is-active');
                                    $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
                                    break;
                                case 'redirect':
                                    location.href = response.url;
                                    break;
                            }
                        }

                    },
                    fail: function(response)
                    {
                        alert('Something went wrong');
                    }
                });
            } else if (expectForm) {
                formContainer.html('');
                row.find('.btn-listing.is-active').removeClass('is-active');
                $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
            }
        }

        function ajaxGet(e)
        {
            e.preventDefault();
            var me  =   $(this),
                row =   $(this).parents('.member-area__content__property-list__item:eq(0)');
            if (ajaxing) {
                ajaxing.abort();
                ajaxing = null;
            }

            ajaxing = $.get(
                $(this).attr('href'),
                function(response)
                {
                    $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
                    var formContainer = me.parents('div.forms:eq(0)');
                    var newForm = $(response).find('form');
                    newForm.find('a:not(".do-cancel, .btn-file-browser, .photos-row a")').unbind('click').click(ajaxGet);
                    formContainer.find('input[name="action_doCancel"], .do-cancel').click(function(e)
                    {
                        e.preventDefault();
                        formContainer.html('');
                        formContainer.parent().find('.btn-listing.is-active').removeClass('is-active');
                        $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
                    });
                    formContainer.find('form').replaceWith(newForm);
                    ajaxForm(formContainer, true);
                }
            );
        }

        return self;
    };
 })(jQuery);

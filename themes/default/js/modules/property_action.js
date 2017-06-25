(function($)
{
	$.fn.propertyAction = function()
    {
        var ajaxing = null;

        $(this).click(function(e)
        {
            e.preventDefault();
            if (ajaxing) {
                ajaxing.abort();
                ajaxing = null;
            }

            if ($(this).hasClass('is-active')) {

                $(this).removeClass('is-active');
                $(this).parents('.member-area__content__property-list__item__info:eq(0)').find('.forms').html('');

                return false;
            }

            $(this).addClass('is-loading');
            var formContainer   =   $(this).parents('.member-area__content__property-list__item__info:eq(0)').find('.forms'),
                me              =   $(this),
                row             =   $(this).parents('.member-area__content__property-list__item:eq(0)');
            formContainer.html('');
            ajaxing = $.get($(this).attr('href'), function(data)
            {
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
                formContainer.find('input[name="action_doCancel"]').click(function(e)
                {
                    e.preventDefault();
                    row.find('.btn-listing.is-active').removeClass('is-active');
                    formContainer.html('');
                    $.scrollTo(row, 500, {axis: 'y', offset: -60});
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

                formContainer.find('a.btn-listing').propertyAction();
                $.scrollTo(row, 500, {axis: 'y', offset: -$('#header').outerHeight()});
            });
        });
    };
 })(jQuery);

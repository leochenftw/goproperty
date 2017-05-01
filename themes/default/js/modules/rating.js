(function($)
{
	$.fn.rating = function()
    {
        var self            =   $(this),
            type            =   $(this).data('type'),
            id             =   $(this).data('id'),
            sid             =   $(this).data('sid');

        $(this).find('li').click(function(e)
        {
            var stars       =   $(this).data('stars'),
                endpoint    =   '/api/v1/rating/' + type + '/';
            $.post(
                endpoint + id,
                {
                    stars: stars,
                    sid: sid
                },
                function(data)
                {
                    var ul = $('ul.rating[data-id="' + id + '"][data-type="' + type + '"]');
                    if (data.message == 'rated') {
                        ul.addClass('rated');
                    } else {
                        ul.removeClass('rated');
                    }
                    ul.parent().find('.rating-count').html('(' + data.count + ' rating' + (data.count > 1 ? 's' : '') + ')');
                    ul.html(data.html);
                    ul.rating();
                }
            );
        });
    };
 })(jQuery);

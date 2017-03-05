(function($)
{
	$.fn.rating = function()
    {
        var self        =   $(this),
            endpoint    =   '/api/v1/rating/',
            uid         =   $(this).data('uid'),
            sid         =   $(this).data('sid');

        $(this).find('li').click(function(e)
        {
            var stars = $(this).data('stars');
            $.post(
                endpoint + uid,
                {
                    stars: stars,
                    sid: sid
                },
                function(data)
                {
                    $('ul.rating[data-uid="' + uid + '"]').html(data.html);
                    $('ul.rating[data-uid="' + uid + '"]').rating();
                }
            );
        });
    };
 })(jQuery);

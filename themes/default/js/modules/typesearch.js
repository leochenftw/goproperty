(function($)
{
    $.fn.typeSearch = function(cbf)
    {
        var self        =   $(this),
            callback    =   cbf,
            endpoint    =   $(this).data('endpoint'),
            container   =   $(this).parents('form:eq(0)').find('.candidates'),
            sid         =   $(this).parents('form:eq(0)').find('input[name="SecurityID"]').val(),
            ajax        =   null,
            emitter     =   null;

        $(this).keydown(function(e)
        {
            if (emitter) {
                clearTimeout(emitter);
                emitter = null;
            }
        }).keyup(function(e)
        {
            container.html('');
            var search  =   $.trim($(this).val());
            if (search.length >= 3) {
                if (emitter) {
                    clearTimeout(emitter);
                    emitter = null;
                }
                if (ajax) ajax.abort();
                emitter = setTimeout(function()
                {
                    ajax    =   $.get(
                                    endpoint + search,
                                    {
                                        securityID: sid
                                    },
                                    function(data)
                                    {
                                        ajax = null;
                                        callback(data);
                                    }
                                );
                }, 300);
            } else if (search.length == 0){
                container.html('');
            }
        });
    };
 })(jQuery);

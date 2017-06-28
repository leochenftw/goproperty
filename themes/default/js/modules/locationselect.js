(function($) {
    $.fn.locationSelect = function() {
        var endpoint        =   '/api/v1/location/',
            childName       =   '#' + $(this).data('direct-child'),
            form            =   $(this).parents('form:eq(0)');

        $(this).change(function(e)
        {
            var first       =   $(childName).find('option:eq(0)').remove();
            $(childName).find('option').remove();
            $(childName).append(first);
            $(childName).change();
            var region      =   form.find('select[name="Region"] option:selected').val().replace(/\//g, "-"),
                district    =   form.find('select[name="City"] option:selected').val(),
                url         =   endpoint + region + (district.length > 0 ? ('/' + district) : ''),
                levelCond   =   '';

            if ($(this).attr('name') == 'Region') {
                levelCond = region;
            } else if ($(this).attr('name') == 'City') {
                levelCond = district;
            }

            if (levelCond.length > 0) {
                $.get(url, function(data)
                {
                    var to      =   form.find('select[name="' + data.to + '"]'),
                        options =   data.options,
                        preset  =   to.data('option'),
                        trigger =   false;
                    for (var i = 0; i < options.length; i++)
                    {
                        var opt =   $('<option />');
                        opt.val(options[i]);
                        opt.html(options[i]);
                        if (preset) {
                            if (options[i] == preset || options[i].toLowerCase().replace(/ /gi, '-') == preset || options[i].toLowerCase() == preset) {
                                opt.prop('selected', true);
                                trigger = true;
                            }
                        }
                        to.append(opt);
                    }

                    if (trigger) {
                        to.change();
                    }
                });
            }

        });
        return this;
    };
})(jQuery);

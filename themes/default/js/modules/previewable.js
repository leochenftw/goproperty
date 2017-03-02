(function($)
{
    $.fn.previewable = function()
    {
        var self            =   $(this),
            destination     =   $(this).parents('form:eq(0)').find('.' + $(this).data('destination'));

        $(this).change(function(e)
        {
            var input       =   $(this)[0];
            if (input.files && input.files[0]) {

                if (input.files[0].type != 'image/png' && input.files[0].type != 'image/jpeg') {
                    var error = new simplayer(
                                    'Wrong file',
                                    'You may only upload JPEG or PNG ',
                                    null,
                                    9999
                                );
                    error.show();
                    $(input).val('');
                }else{
                    var reader  =   new FileReader(),
                        theform =   $(input).parents('form:eq(0)');
                    //TweenMax.to($('#docking-bay'), 0.1, {opacity: 0});
                    reader.onload = function (e) {
                        var img = $('<img />');
                        img.attr('src', e.target.result);
                        destination.html(img);

                    }

                    reader.readAsDataURL(input.files[0]);
                }
            }
        });

    };
 })(jQuery);

(function($)
{
    $.fn.previewable = function()
    {
        var self            =   $(this),
            destination     =   $(this).parents('form:eq(0)').find('.' + $(this).data('destination')),
            template        =   '<div class="message is-danger overlay-element">\
                                    <div class="message-header">\
                                        <p></p>\
                                        <button class="delete"></button>\
                                    </div>\
                                    <div class="message-body"></div>\
                                </div>';

        $(this).change(function(e)
        {
            var input       =   $(this)[0];
            if (input.files && input.files[0]) {

                if (input.files[0].type != 'image/png' && input.files[0].type != 'image/jpeg') {
                    var error = $(template);
                    error.find('.message-header p').html('Wrong file');
                    error.find('.message-body').html('You may only upload JPEG or PNG ');
                    error.find('button.delete').click(function(e)
                    {
                        $('html').removeClass('locked');
                        $('body').removeClass('overlayed');
                        error.remove();
                    });
                    $(input).val('');
                    $('html').addClass('locked');
                    $('body').addClass('overlayed').append(error);
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

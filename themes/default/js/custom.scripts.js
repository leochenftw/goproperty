window.gplaceapi = 'AIzaSyC0iYnTDuwXR7d1hdo1Gd-QTCFfqoAyNR4';
$(document).ready(function(e)
{
    if ($('.message.notification').length > 0) {
        $('.message.notification').removeClass('message');
    }

    if ($('.component-switch-board').length > 0) {

        var initialLR   =   QueryString ? (QueryString.RentOrSale ? QueryString.RentOrSale  : '') : '';

        $('.component-switch-board').click(function(e)
        {
            var direction   =   'left',
                leftcheck   =   $(this).data('left'),
                rightcheck  =   $(this).data('right'),
                form        =   $(this).parents('form:eq(0)');
                toCheck     =   null;

            if ($(e.target).is('.switch-label')) {
                direction   =   $(e.target).data('lr');
            } else if ($(e.target).is('.switch-board') || $(e.target).is('.switch')) {
                direction   =   $(e.target).hasClass('at-right') || $(e.target).parent().hasClass('at-right') ? 'left' : 'right';
            }

            toCheck         =   direction == 'left' ? leftcheck : rightcheck;

            $(this).find('.switch-board').removeClass('at-left').removeClass('at-right').addClass('at-' + direction);
            $(toCheck).prop('checked', true);

            var picked      =   $(toCheck).val();

            if (picked == 'sale') {
                form.find('.for-sale').removeClass('hide');
                form.find('.for-rent').addClass('hide');
                form.find('input[name="RentFrom"], input[name="RentTo"]').val('');
            } else {
                form.find('.for-rent').removeClass('hide');
                form.find('.for-sale').addClass('hide');
                form.find('input[name="PriceFrom"], input[name="PriceTo"]').val('');
            }

        });

        if (initialLR == 'sale') {
            $('.component-switch-board .switch-label[data-lr="right"]').click();
        }
    }

    $('.show-search-form').click(function(e)
    {
        e.preventDefault();
        if ($(this).hasClass('flipped')) {
            $(this).removeClass('flipped');
            $('.search-forms').addClass('hide');
            $('.criteria').removeClass('hide');
            if ($(this).is('.button')) {
                $(this).html('Refine the result');
            }
        } else {
            $(this).addClass('flipped');
            $('.search-forms').removeClass('hide');
            $('.criteria').addClass('hide');
            if ($(this).is('.button')) {
                $(this).html('Close');
            }

            if ($('body').hasClass('page-type-error-page')) {
                $('h1.title, .content').addClass('hide');
            }
        }
    });

    $('.hb-engaged').click(function(e)
    {
        e.preventDefault();
        var endpoint        =   $(this).attr('href'),
            templatefile    =   $(this).data('template'),
            csrf            =   $(this).data('csrf'),
            me              =   $(this),
            parent          =   $(this).parent();

        if (!window[templatefile]) {
            console.error('you don\'t even have this template');
            return false;
        }

        if (parent.is('li')) {
            if (parent.is('.is-active') && e.originalEvent) {
                return false;
            }

            var siblings = parent.siblings();
            siblings.removeClass('is-active');
            parent.addClass('is-active');
        }

        $.get(
            endpoint,
            {
                'SecurityID'    :   csrf
            },
            function(data)
            {
                var template    =   Handlebars.compile(window[templatefile]),
                    popup       =   template(data);

                popup           =   $(popup);

                $('#hd-ajaxed-content').html(popup);

                if (templatefile == 'appointmentListTemplate') {
                    popup.find('.dt-picker').datetimepicker(
                    {
                        lazyInit: true,
                        step: 15,
                        minDate: 0,
                        format: 'Y-m-d H:i',
                        scrollInput: false
                    });

                    popup.find('.actions a.button').click(function(e)
                    {
                        e.preventDefault();

                        var me          =   $(this),
                            endpoint    =   $(this).data('action'),
                            csrf        =   $(this).data('csrf')
                            row         =   me.parents('.appointment-item:eq(0)'),
                            post        =   function()
                                            {
                                                $.post(
                                                    endpoint,
                                                    {
                                                        SecurityID: csrf
                                                    },
                                                    function(data)
                                                    {
                                                        if (data) {
                                                            row.remove();
                                                        }
                                                    }
                                                );
                                            };

                        if (me.is('.red')) {
                            if (confirm('You are cancelling this appointment. Are you sure?')) {
                                post();
                            }
                        } else {
                            post();
                        }
                    });

                    popup.find('form').each(function(i, el)
                    {
                        var me  =   $(this),
                            btn =   me.find('button[type="submit"]'),
                            row =   me.parents('.appointment-item:eq(0)');

                        me.find('.display').click(function(e)
                        {
                            e.preventDefault();
                            me.find('.editor').removeClass('hide');
                            me.find('.display').addClass('hide');
                            row.find('.actions').addClass('hide');
                        });

                        me.find('.btn-cancel').click(function(e)
                        {
                            e.preventDefault();
                            row.find('.actions').removeClass('hide');
                            me.find('.display').removeClass('hide');
                            me.find('.editor').addClass('hide');
                        });

                        me.ajaxSubmit(
                        {
                            onstart: function()
                            {
                                btn.addClass('is-loading');
                            },

                            validator: function()
                            {
                                me.find('.is-danger').removeClass('is-danger');
                                var b = $.trim(me.find('.dt-picker').val()).length > 0;
                                if (!b) {
                                    me.find('.dt-picker').addClass('is-danger');
                                }
                                return b;
                            },

                            success: function(data)
                            {
                                me.find('.display .date').html('Appointment at: ' + me.find('.dt-picker').val());
                                if ($.trim(me.find('.textarea').val()).length > 0) {
                                    me.find('.display .memo').html('Memo: ' + me.find('.textarea').val());
                                } else {
                                    me.find('.display .memo').html('- no memo -');
                                }
                                row.find('.actions').removeClass('hide');
                                me.find('.display').removeClass('hide');
                                me.find('.editor').addClass('hide');
                            },

                            done: function(data)
                            {
                                btn.removeClass('is-loading');
                            }
                        });
                    });
                }

                if (templatefile == 'serviceRequesterTemplate') {
                    popup.find('.title').click(function(e)
                    {
                        e.preventDefault();
                        if ($(this).parents('.interest-item:eq(0)').data('foldable') == 1) {
                            $(this).parents('.interest-item:eq(0)').toggleClass('fold');
                        }
                    });

                    popup.find('button.button').click(function(e)
                    {
                        e.preventDefault();

                        var sid             =   $(this).data('sid'),
                            endpoint        =   $(this).data('endpoint'),
                            me              =   $(this),
                            theHTML         =   $(this).parents('.interest-item:eq(0)');

                        if (me.is('.red') && theHTML.data('foldable') == 1) {
                            theHTML.addClass('fold');
                            return;
                        }

                        $(this).addClass('is-loading');

                        $.post(
                            endpoint,
                            {
                                SecurityID: sid
                            },
                            function(data)
                            {
                                $(this).removeClass('is-loading');

                                if (me.is('.red')) {
                                    if (data === true) {
                                        theHTML.addClass('fold').attr('data-foldable', 1);
                                    }
                                } else if (me.is('.green')) {
                                    $('.tab-appointments').click();
                                }
                            }
                        );
                    });
                }
            }
        );
    });

    $('.hb-engaged.auto-fire').click();

    if ($('.btn-listing').length > 0) {
        $('.btn-listing').propertyAction();
    }

    if ($('.btn-delete').length > 0) {
        $('.btn-delete').click(function(e)
        {
            e.preventDefault();
            if (confirm('Are you sure you want to remove this agency?')) {
                var url     =   $(this).attr('href'),
                    csrf    =   $(this).data('csrf'),
                    item    =   $(this).parents('.member-area__content__property-list__item:eq(0)');
                $.ajax({
                    url: url,
                    type: 'DELETE',
                    data: {
                        SecurityID: csrf
                    },
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function(result)
                    {
                        item.remove();
                    }
                });
            }
        });
    }

    if ($('body').hasClass('page-dashboard')) {
        $(".member-area__sidebar ul.neat-ul").fixy($('#header').outerHeight());
        if ($(".member-area__content .fields__aside .uploader").length > 0) {
            $(".member-area__content .fields__aside .uploader").fixy($('#header').outerHeight());
        }
    }

    $('#FeedbackForm_FeedbackForm_Stars').change(function(e)
    {
        var n = $(this).val().toFloat();
        $('ul.rating .fa').removeClass('fa-star').addClass('fa-star-o');
        $('ul.rating .fa:lt(' + n + ')').removeClass('fa-star-o').addClass('fa-star');
    }).change();

    $('.property__content-area__testimonial .comments .comment .ratings').each(function(i, el)
    {
        $(this).find('.fa:lt(' + $(this).data('stars') + ')').removeClass('fa-star-o').addClass('fa-star');
    });

    $(window).scroll(function(e)
    {
        if ($(this).scrollTop() >= 100) {
            if (!$('body').hasClass('short-header')) {
                $('body').addClass('short-header');
            }
        } else if ($(this).scrollTop() <= 50) {
            if ($('body').hasClass('short-header')) {
                $('body').removeClass('short-header');
            }
        }
    }).scroll();

    $('.btn-terminate').click(function(e)
    {
        e.preventDefault();
        if (confirm('Are you sure you want to terminate the lease?')) {
            var rentalID        =   $(this).data('rental-id'),
                propertyID      =   $(this).data('property-id'),
                SessionID       =   $(this).data('sid');

            $(this).addClass('is-loading');

            $.post(
                '/api/v1/rental/' + rentalID + '/' + propertyID,
                {
                    'SecurityID': SessionID
                },
                function(data)
                {
                    console.log(data);
                    location.reload();
                }
            );
        }
    });

    $('.btn-view-applicants').click(function(e)
    {
        e.preventDefault();
        var sid             =   $(this).data('sid'),
            propertyid      =   $(this).data('id'),
            title           =   $(this).data('title');
        $.get(
            '/api/v1/eoi/' + propertyid,
            {
                SecurityID: sid
            },
            function(data)
            {
                var list = new InterestList(title, data);
                $('html').addClass('locked');
                $('body').addClass('overlayed fixed').append(list);
            }
        );
    });

    $('.btn-rm-fav').click(function(e)
    {
        e.preventDefault();
        if (confirm('You are removing this wishlist item. Click "OK" to proceed.')) {
            var thisLink    =   $(this),
                url         =   $(this).attr('href'),
                classname   =   $(this).data('class'),
                id          =   $(this).data('id'),
                li          =   $(this).parents('li.member-area__content__property-list__item:eq(0)'),
                data        =   {
                                    'class' :   classname,
                                    'id'    :   id
                                };
            $.post(url, data, function(response)
            {
                console.log(response);
                if (response.html == 'Wishlist') {
                    li.remove();
                }
            });
        }
    });

    $('.btn-fav').click(function(e)
    {
        e.preventDefault();
        var thisLink    =   $(this),
            url         =   $(this).attr('href'),
            classname   =   $(this).data('class'),
            id          =   $(this).data('id'),
            data        =   {
                                'class' :   classname,
                                'id'    :   id
                            };
        $.post(url, data, function(response)
        {
            thisLink.removeClass('icon-heart').removeClass('icon-heart-empty');
            thisLink.addClass(response.css_class);
            thisLink.html(response.html);
        });
    });

    $('#BusinessForm_BusinessForm_ServicesInput').change(function(e)
    {
        if ($(this).val()) {
            var idx         =   $(this).val(),
                newService  =   $('<div />').addClass('field dropdown nolabel'),
                newItem     =   $(this).clone();
            newItem.attr('name', 'Services[]');
            newItem.find('option[value="' + idx+ '"]').prop('selected', true);
            newService.html('<div class="middleColumn is-new"></div>');
            newService.find('.middleColumn').append(newItem);
            newService.insertAfter($('#BusinessForm_BusinessForm_ServicesInput_Holder'));
            $(this).find('option:eq(0)').prop('selected', true);
        }
    });

    $('input[name="ListTilGone"]').change(function(e)
    {
        if ($(this).prop('checked')) {
            if ($(this).val() == 1) {
                $('.fields__main__section.listing').addClass('hide');
                $('#RentForm_RentForm_ListingCloseOn').val('');
            } else {
                $('.fields__main__section.listing').removeClass('hide');
            }
        }
    }).change();

    $('.owl-carousel').owlCarousel(
        {
            loop: false,
            margin: 10,
            nav: true,
            autoWidth: true,
            items: 6
        }
    );

    if ($('#ContactForm_ContactForm_error').length == 1 && $('#ContactForm_ContactForm_error').hasClass('good')) {
        $('#ContactForm_ContactForm_error').prependTo($('.section.property'));
        var withDrawMessage = function(e)
        {
            if (tick) {
                clearTimeout(tick);
                tick = null;
                TweenMax.to($('#ContactForm_ContactForm_error'), 0.5, {opacity: 0, onComplete:function()
                {
                    $('#ContactForm_ContactForm_error').remove();
                }});
            }
        };
        var tick = setTimeout(withDrawMessage, 3000);
        $('#ContactForm_ContactForm_error').click(withDrawMessage);
    }

    if ($('#PropertyForm_Message').length == 1) {
        var withDrawMessage = function(e)
        {
            if (e) {
                e.preventDefault();
            }

            if (tick) {
                clearTimeout(tick);
                tick = null;
                TweenMax.to($('#PropertyForm_Message'), 0.5, {opacity: 0, onComplete:function()
                {
                    $('#PropertyForm_Message').remove();
                }});
            }
        };
        var tick = setTimeout(withDrawMessage, 5000);
        $('#PropertyForm_Message button').click(withDrawMessage);
    }

    $('#ContactForm_ContactForm').ajaxSubmit(
    {
        success: function(data)
        {
            $('#contact-form-holder .loading-message').removeClass('hide');
            $('#ContactForm_ContactForm').addClass('hide');
        },

        done: function(data)
        {
            var message = '';
            try {
                data = JSON.parse(data);
                message = data.message;
            } catch (e) {
                message = 'something went wrong';
            }

            $('#contact-form-holder .loading-message').addClass('hide');
            $('#contact-form-holder .columns').removeClass('hide');
            $('#contact-form-holder .postback-message').html(message);
        }
    });

    $('#contact-form-holder button.delete, #contact-form-holder .close-this').click(function(e)
    {
        e.preventDefault();
        $('html').removeClass('locked');
        $('body').removeClass('overlayed fixed');
        $('#contact-form-holder').addClass('hide').insertAfter('.member-tile');
        $('#contact-form-holder .columns').addClass('hide');
        $('#ContactForm_ContactForm').removeClass('hide');
        $('#contact-form-holder .postback-message').html('');
        $('#ContactForm_ContactForm_Content').val('');
    });

    $('#btn-contact-form').click(function(e)
    {
        e.preventDefault();
        $('html').addClass('locked');
        $('body').addClass('overlayed fixed');
        $('#contact-form-holder').removeClass('hide').appendTo('body');
    });

    $('.filter-form button').click(function(e)
    {
        e.preventDefault();
        var form    =   $(this).parents('.filter-form:eq(0)'),
            name    =   $(this).attr('name'),
            me      =   form.find('[name="'+name+'"]'),
            prt     =   $(this).parent();

        prt.hide();
        me.remove();
        if (name == 'region') {
            form.find('[name="district"], [name="suburb"]').each(function(i, el)
            {
                $(this).parent().hide();
            });
            form.find('[name="district"], [name="suburb"]').remove();
        }

        if (name == 'district') {
            form.find('[name="suburb"]').each(function(i, el)
            {
                $(this).parent().hide();
            });
            form.find('[name="suburb"]').remove();
        }

        var segments = [form.find('[name="region"]').html(), form.find('[name="district"]').html(), form.find('[name="suburb"]').html()];
        var url = '/';
        for (var i = 0; i < segments.length; i++) {
            if (segments[i] !== undefined) {
                url += segments[i] + '/';
            }
        }

        form.attr('action', form.attr('action') + url );
        form.submit();
    });

    // if ($('body').hasClass('page-type-property-page') || $('body').hasClass('page-type-business')) {
    //     $('ul.rating').each(function(i, el)
    //     {
    //         $(this).rating();
    //     });
    // }

    if ($('body').hasClass('activation')) {
        setTimeout(function()
        {
            location.replace('/member');
        }, 5000);
    }

    var updateAccountAmount = function()
    {
        var n = 0;
        $('#account-types li.checked').each(function(i, el)
        {
            n += $(this).data('price').toFloat();
        });

        $('#amount-due').html(n.toDollar());
    };

    $('#AccountType .optionset input.checkbox, #SignupToBe  .optionset input.checkbox').each(function(i, el)
    {
        var id = $(this).attr('id');
        if ($(this).prop('checked')) {
            $('#account-types li[data-target="' + id + '"]').addClass('checked');
        }

        updateAccountAmount();
    });

    $('#account-types li').click(function(e)
    {
        e.preventDefault();
        $(this).toggleClass('checked');
        $('#' + $(this).data('target')).prop('checked', $(this).hasClass('checked'));
        updateAccountAmount();
    });

    $('.tab-ish.search-tab').click(function(e)
    {
        e.preventDefault();
        $('#form-description span').html($(this).data('description'));
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
        var show    =   $(this).data('show'),
            hide    =   $(this).data('hide'),
            form    =   $($(this).attr('href').replace('/#', '#'));
        $('.search-forms form').addClass('hide');
        form.removeClass('hide');
        form.find('.' + show).removeClass('hide');
        form.find('.' + hide).each(function(i, el)
        {
            $(this).addClass('hide');
            $(this).find('input.text').val('');
            $(this).find('select option').prop('selected', false);
            $(this).find('input.radio').prop('checked', false);
        });

        if ($(this).attr('href').replace('/#', '#') == '#PropertySearchForm_PropertySearchForm') {
            if ($(this).data('show') == 'for-sale') {
                $('#PropertySearchForm_PropertySearchForm_RentOrSale_sale').prop('checked', true);
            } else {
                $('#PropertySearchForm_PropertySearchForm_RentOrSale_rent').prop('checked', true);
            }
        }

    });

    if ($('#property-gallery').length == 1) {
        $('#property-gallery a.thumbnail').click(function(e)
        {
            e.preventDefault();
            var url = $(this).attr('href');
            $('#property-image-viewer img').attr('src', url);
        });
    }

    if ($('#g-map-hero').length == 1) {
        var map = new gmap(gplaceapi, 'g-map-hero', [{lat: $('#g-map-hero').data('lat').toFloat(), lng: $('#g-map-hero').data('lng').toFloat()}], 17, null, true, true);
    }

    if ($('.google-maps-holder').length > 0) {
        $('.google-maps-holder').each(function(i, el)
        {
            var id = 'google-maps-holder-' + (i + 1);
            $(this).attr('id', id)
            var map = new gmap(gplaceapi, id, [{lat: $(this).data('lat').toFloat(), lng: $(this).data('lng').toFloat()}], 17);
        });
    }

    $('select[name="Region"], select[name="City"]').each(function(i, el)
    {
         $(this).locationSelect().change();
    });


    // $('#PropertySearchForm_PropertySearchForm .location select:not("#PropertySearchForm_PropertySearchForm_Suburb")').each(function(i, el)
    // {
    //     $(this).locationSelect().change();
    // });
    //
    // $('#TradesmenSearchForm_TradesmenSearchForm .location select:not("#TradesmenSearchForm_TradesmenSearchForm_Suburb")').each(function(i, el)
    // {
    //     $(this).locationSelect().change();
    // });

    if ($('#PropertySearchForm_PropertySearchForm_Availability').length == 1) {
        $('#PropertySearchForm_PropertySearchForm_Availability').datetimepicker(
        {
            timepicker: false,
            format: 'd/m/Y',
            scrollInput: false
        });
    }
    if ($('.docking-bay').length > 0) {

        $('.docking-bay').each(function(i, el)
        {
            var theForm     =   $(this).parents('form:eq(0)'),
                theBtn      =   theForm.find('input[type="file"]');
            if (!$(this).hasClass('cropper-hold')) {
                cropperWork($(this).find('img:eq(0)'), theForm);
            }

            theBtn.change(function(e)
            {
                if (this.value.length > 0) {
                    readURL(this);
                }
            });
        });
    }

    $('.btn-file-browser').click(function(e)
    {
        e.preventDefault();
        var theBtn = $(this).parents('form:eq(0)').find('input[type="file"]');
        theBtn.click();
    });

    if ($('.simple-previewable').length > 0) {
        $('.simple-previewable').previewable();
    }

    if ($('#MemberProfileForm_MemberProfileForm_FullAddress').length > 0) {
        var gplace = new autoAddress(gplaceapi, function()
        {
            var txt     =   gplace.gplacised('MemberProfileForm_MemberProfileForm_FullAddress'),
                form    =   $('#MemberProfileForm_MemberProfileForm');
            txt.addListener('place_changed', function()
            {
                // Get the place details from the autocomplete object.
                var place = txt.getPlace();
                form.find('input[name="Lat"]').val(place.geometry.location.lat());
                form.find('input[name="Lng"]').val(place.geometry.location.lng());

                for (var i = 0; i < place.address_components.length; i++) {
                    var addressType = place.address_components[i].types[0];
                    var field = matchField(addressType);
                    if (field.length > 0) {
                        form.find('input[name="' + field + '"]').val(place.address_components[i].long_name);
                    }

                }
            });
        });
    }

    if ($('#BusinessForm_BusinessForm_FullAddress').length > 0) {
        var gplace = new autoAddress(gplaceapi, function()
        {
            var txt     =   gplace.gplacised('BusinessForm_BusinessForm_FullAddress'),
                form    =   $('#BusinessForm_BusinessForm_FullAddress').parents('form:eq(0)');
            txt.addListener('place_changed', function()
            {
                // Get the place details from the autocomplete object.
                var place = txt.getPlace();
                form.find('input[name="Lat"]').val(place.geometry.location.lat());
                form.find('input[name="Lng"]').val(place.geometry.location.lng());

                for (var i = 0; i < place.address_components.length; i++) {
                    var addressType = place.address_components[i].types[0];
                    var field = matchField(addressType);
                    if (field.length > 0) {
                        form.find('input[name="' + field + '"]').val(place.address_components[i].long_name);
                    }

                }
            });
        });
    }

    if ($('#BusinessForm_BusinessForm_ServicesInput').length == 1) {
        var div = $('<div />').addClass('candidates');
        $('#BusinessForm_BusinessForm_ServicesInput').parent().append(div);
        $('#BusinessForm_BusinessForm_ServicesInput').typeSearch(function(data)
        {
            if (data && data.length > 0) {
                for (var i = 0; i < data.length; i++)
                {
                    var btn = $('<button />');
                    btn.html(data[i].title);
                    btn.attr('data-id', data[i].id);
                    div.append(btn);
                    btn.click(function(e)
                    {
                        e.preventDefault();
                        var input = $('<input type="hidden" name="Services[]" />');
                        input.val(btn.data('id'));
                        input.appendTo('#tagged-services');
                        $(this).appendTo('#tagged-services');
                        div.html('');
                        $('#BusinessForm_BusinessForm_ServicesInput').val('');
                    });

                }
            }
        });
    }

    $('.property-form').each(function(i, el)
    {
        $(this).formWork();
    });

    $('.mini-ajax-form').each(function(i, el)
    {
        $(this).ajaxSubmit(
        {
            success: function(data)
            {
                if (data.code == 307) {
                    window.location.href = data.url;
                }

                if (data.action) {
                    if (data.action == 'refresh') {
                        window.location.reload();
                    }
                }
            },

            done: function(data)
            {

            }
        });
    });

});

function matchField(gprop) {
    var field = '';
    switch (gprop) {
        case 'street_number':
            field = 'StreetNumber';
            break;
        case 'route':
            field = 'StreetName';
            break;
        case 'sublocality_level_1':
            field = 'Suburb';
            break;
        case 'locality':
            field = 'City';
            break;
        case 'administrative_area_level_1':
            field = 'Region';
            break;
        case 'country':
            field = 'Country';
            break;
        case 'postal_code':
            field = 'PostCode';
            break;
    }

    return field;
}

function recaptchaHandler(token)
{
    $('#SignupForm_SignupForm').submit();
}


function cropperWork(img, thisForm, disabled) {
    var w       =   thisForm.find('input.upload').data('width'),
        h       =   thisForm.find('input.upload').data('height'),
        r       =   (w && h) ? w/h : 1,
        cropper =   new Cropper(img[0], {
                        viewMode: 3,
                        aspectRatio: r,
                        zoomable: true,
                        minContainerWidth: w ? w*0.1 : 50,
                        minContainerHeight: h ? h*0.1 : 50,
                        minCropBoxWidth: 50,
                        dragMode: 'move',
                        guides: disabled ? false : true,
                        crop: function(e) {
                            var x = Math.round(cropper.getCanvasData().left * -1),
                                y = Math.round(cropper.getCanvasData().top * -1),
                                w = Math.round(cropper.getCanvasData().width),
                                h = Math.round(cropper.getCanvasData().height),
                                cx = Math.round(cropper.getCropBoxData().left),
                                cy = Math.round(cropper.getCropBoxData().top),
                                cw = Math.round(cropper.getCropBoxData().width),
                                ch = Math.round(cropper.getCropBoxData().height);

                            thisForm.find('input[name="ContainerX"]').val(x);
                            thisForm.find('input[name="ContainerY"]').val(y);
                            thisForm.find('input[name="ContainerWidth"]').val(w);
                            thisForm.find('input[name="ContainerHeight"]').val(h);

                            thisForm.find('input[name="CropperX"]').val(cx);
                            thisForm.find('input[name="CropperY"]').val(cy);
                            thisForm.find('input[name="CropperWidth"]').val(cw);
                            thisForm.find('input[name="CropperHeight"]').val(ch);
                        },
                        ready: function() {


                            if (disabled) {
                                cropper.setCropBoxData({top: 0, left: 0, width: img.parents('.thumbnail-core:eq(0)').width(), height: img.parents('.thumbnail-core:eq(0)').height()});
                                cropper.disable();
                            } else {
                                var CropperData = {
                                        left: thisForm.find('input[name="CropperX"]').val() ? thisForm.find('input[name="CropperX"]').val().toFloat() : 0,
                                        top: thisForm.find('input[name="CropperY"]').val() ? thisForm.find('input[name="CropperY"]').val().toFloat() : 0,
                                        width: thisForm.find('input[name="CropperWidth"]').val() ? thisForm.find('input[name="CropperWidth"]').val().toFloat() : 0,
                                        height: thisForm.find('input[name="CropperHeight"]').val() ? thisForm.find('input[name="CropperHeight"]').val().toFloat() : 0
                                    },
                                    CanvasData = {
                                        left: thisForm.find('input[name="ContainerX"]').val() ? thisForm.find('input[name="ContainerX"]').val().toFloat() * -1 : 0,
                                        top: thisForm.find('input[name="ContainerY"]').val() ? thisForm.find('input[name="ContainerY"]').val().toFloat() * -1 : 0,
                                        width: thisForm.find('input[name="ContainerWidth"]').val() ? thisForm.find('input[name="ContainerWidth"]').val().toFloat() : 0,
                                        height: thisForm.find('input[name="ContainerHeight"]').val() ? thisForm.find('input[name="ContainerHeight"]').val().toFloat() : 0
                                    };

                                cropper.setCanvasData(CanvasData);
                                cropper.setCropBoxData(CropperData);
                            }
                        }
                    });
}

function readURL(input) {
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
                theform.find('.docking-bay').html(img);
                setTimeout(function(){
                    // if (img.width() > img.height()) {
                    //     _isLandscape = true
                    // }
                    cropperWork(img, theform);
                    // _primInput.remove();
                    // _secInput.attr('id', _secInput.attr('id').replace('-fake',''));
                    // _primInput = _secInput.removeClass('drop-zone');
                    // _secInput = _primInput.clone();
                    // _secInput.attr('id', _secInput.attr('id') + '-fake').hide();
                    // _secInput.addClass('drop-zone');
                    // _secInput.insertAfter(_primInput);
                    // _secInput.change(function(){
                    //     if (this.value.length > 0) {
                    //         _secInput.hide();
                    //         (this);
                    //     }
                    // });
                }, 100);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
}

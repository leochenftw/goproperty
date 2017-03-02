window.gplaceapi = 'AIzaSyC0iYnTDuwXR7d1hdo1Gd-QTCFfqoAyNR4';
$(document).ready(function(e)
{
    $('.owl-carousel').owlCarousel(
        {
            loop: false,
            margin: 10,
            nav: true,
            autoWidth: true,
            items: 6
        }
    );

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
        trace('wtf');
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
        })

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


    $('#PropertySearchForm_PropertySearchForm .location select:not("#PropertySearchForm_PropertySearchForm_Suburb")').each(function(i, el)
    {
        $(this).locationSelect();
    });

    $('#TradesmenSearchForm_TradesmenSearchForm .location select:not("#TradesmenSearchForm_TradesmenSearchForm_Suburb")').each(function(i, el)
    {
        $(this).locationSelect();
    });

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

/**
 * - callbacks: null | {
        onstart: function | null,
        sucess: function | null,
        fail: function | null,
        done: function | null
     }
 * */
(function($) {
    $.fn.formWork = function() {
        if ($('#AccountUpgradeForm_AccountUpgradeForm').length > 0) return;
        var self        =   $(this),
            gplaceid    =   $(this).find('input.google-placed').attr('id'),
            auto_idx    =   0,
            existings   =   $(this).find('input[name="ExistingGallery"]').val(),
            todelete    =   [],
            gplace      =   gplaceid ? new autoAddress(gplaceapi, function()
            {
                var txt     =   gplace.gplacised(gplaceid),
                    form    =   self;
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
                    trace(self.find('input[name="Lat"]').val().toFloat() +', '+ self.find('input[name="Lng"]').val().toFloat());
                    map.update(self.find('input[name="Lat"]').val().toFloat(), self.find('input[name="Lng"]').val().toFloat());
                });
            }) : null,
            _lat       =    self.find('input[name="Lat"]').length > 0 ? self.find('input[name="Lat"]').val().toFloat() : null,
            _lng       =    self.find('input[name="Lng"]').length > 0 ? self.find('input[name="Lng"]').val().toFloat() : null,
            //-41.3993353,173.0164209
            map        =    gplace ? new gmap(gplaceapi, 'location-on-map', [{lat: (_lat == 0 ? -41.3993353 : _lat), lng: (_lng == 0 ? 173.0164209 : _lng)}]) : null,
            scrollThumbnail = function()
            {
                $('.previewable-uploader__previewable').scrollTo($('.previewable-uploader__previewable .previewable-uploader__previewable__thumbnail:last'), 500, {axis: 'x'});
            },

            loadImage   =   function(input)
            {
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
                        var reader      =   new FileReader(),
                            theform     =   $(input).parents('form:eq(0)');
                        theform.find('.previewable-uploader__previewable').removeClass('hide');
                        auto_idx++;
                        reader.onload = function (e) {
                            var img     =   $('<img />'),
                                div     =   $('<div />'),
                                dimg    =   $('<div />'),
                                btn     =   $('<button data-idx="' + auto_idx + '" />');

                            btn.addClass('btn-remove-thumbnail icon-close').html('remove');
                            dimg.addClass('thumbnail-core');
                            div.addClass('previewable-uploader__previewable__thumbnail relative');
                            dimg.width(92);
                            dimg.height(92);

                            btn.click(function(e)
                            {
                                e.preventDefault();
                                $(this).parent().remove();
                                var idx = $(this).data('idx');
                                theform.find('input.viewable-gallery[data-idx="' + idx + '"]').remove();
                                theform.find('.previewable-uploader').removeClass('limit-reached');
                                if (theform.find('.previewable-uploader__previewable__thumbnail').length == 0) {
                                    theform.find('.previewable-uploader__previewable').addClass('hide');
                                }

                                theform.find('.previewable-uploader__uploadable input[name="Gallery[Uploads][]"]:last').removeClass('hide');
                            });

                            img.attr('src', e.target.result);
                            dimg.html(img);
                            div.append(dimg).append(btn);

                            theform.find('.previewable-uploader__previewable').append(div);
                            scrollThumbnail();
                            setTimeout(function(){
                                cropperWork(img, theform, true);
                                dimg.addClass('show');
                            }, 100);
                            var newInput = $(input).clone(true);
                            $(input).attr('data-idx', auto_idx).hide();
                            newInput.val('');
                            newInput.insertAfter($(input));
                            // if (theform.find('.previewable-uploader__previewable__thumbnail').length >= 10) {
                            //     newInput.addClass('hide');
                            //     theform.find('.previewable-uploader').addClass('limit-reached');
                            // }
                        }

                        reader.readAsDataURL(input.files[0]);
                    }
                }
            };

        self.find('input.viewable-gallery').removeAttr('id').change(function(e)
        {
            if (this.value.length > 0) {
                loadImage(this);
            }
        });

        self.find('#PriceOption input.radio').change(function(e)
        {
            $('#AskingPrice_Holder, #EnquiriesOver_Holder, #AuctionOn_Holder, #TenderCloseOn_Holder, #PrivateTreatyDeadline_Holder').addClass('hide');
            var toShowID        =   $(this).val(),
                toShow          =   self.find('input[name="' + toShowID + '"]'),
                toShowHolder    =   toShow.parents('.field:eq(0)');

            toShow.removeClass('hide');
            toShowHolder.removeClass('hide');
        });

        self.find('select[name="ListerAgencyID"]').change(function(e)
        {
            var opt = $(this).find('option:selected');
            if (opt.val().length > 0) {
                console.log('huh?');
                $('#SaleForm_SaleForm_AgencyReference_Holder, #SaleForm_SaleForm_AgencyReference, #RentForm_RentForm_AgencyReference_Holder, #RentForm_RentForm_AgencyReference').removeClass('hide');
            } else {
                $('#SaleForm_SaleForm_AgencyReference_Holder, #SaleForm_SaleForm_AgencyReference, #RentForm_RentForm_AgencyReference_Holder, #RentForm_RentForm_AgencyReference').addClass('hide');
            }
        });

        self.find('input[name="DateAvailable"], input[name="AuctionOn"], input[name="TenderCloseOn"], input[name="PrivateTreatyDeadline"], input[name="ListingCloseOn"]').datetimepicker(
        {
            timepicker: false,
            format: 'Y-m-d',
            scrollInput: false
        });

        if (existings) {
            existings = existings.split(',');
            self.find('.btn-remove-thumbnail.solid').click(function(e)
            {
                e.preventDefault();
                var id  =   $(this).data('id');
                existings.removeByValue(id.toString());
                self.find('input[name="ExistingGallery"]').val(existings.toString());
                todelete.push(id);
                self.find('input[name="toDelete"]').val(todelete.toString());
                $(this).parent().remove();
                self.find('.previewable-uploader').removeClass('limit-reached');
                if (self.find('.previewable-uploader__previewable__thumbnail').length == 0) {
                    self.find('.previewable-uploader__previewable').addClass('hide');
                }

                self.find('.previewable-uploader__uploadable input[name="Gallery[Uploads][]"]:last').removeClass('hide');
            });
        }

        $(this).find('input.text').keydown(function(e)
        {
            if (e.keyCode == 13) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
    };
})(jQuery);

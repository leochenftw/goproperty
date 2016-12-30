$(document).ready(function(e)
{
    if ($('.docking-bay').length > 0) {

        $('.docking-bay').each(function(i, el)
        {
            var theForm     =   $(this).parents('form:eq(0)'),
                theBtn      =   theForm.find('input[type="file"]');
            if (!$(this).hasClass('cropper-hold')) {
                cropperWork($(this).find('img:eq(0)'), theForm);
            }

            $(this).parents('form:eq(0)').find('.btn-file-browser').click(function(e)
            {
                e.preventDefault();
                theBtn.click();
            });

            theBtn.change(function(e)
            {
                if (this.value.length > 0) {
                    readURL(this);
                }
            });
        });

    }

});

function recaptchaHandler(token)
{
    $('#SignupForm_SignupForm').submit();
}

function cropperWork(img, thisForm, disabled) {
    var cropper = new Cropper(img[0], {
        viewMode: 3,
        aspectRatio: 1,
        zoomable: true,
        minContainerWidth: 50,
        minContainerHeight: 50,
        minCropBoxWidth: 50,
        dragMode: 'move',
        guide: false,
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

            var data = {
                left: thisForm.find('input[name="CropperX"]').val().toFloat(),
                top: thisForm.find('input[name="CropperY"]').val().toFloat(),
                width: thisForm.find('input[name="CropperWidth"]').val().toFloat(),
                height: thisForm.find('input[name="CropperHeight"]').val().toFloat()
            };
            trace(data);
            cropper.setCropBoxData(data);
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

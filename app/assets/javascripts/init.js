// below functionality in separate functions because they need to be invoke cocoon callbacks also with document.ready
var uploadImageAssetSource;
var previewImageAssetSource; 
var buttonActionsBtnTypeChange;

//ImageAssets: a common function to replace the source of file input with selected once
uploadImageAssetSource = function(input) {
    var reader;
    if (input.files && input.files[0]) {
        reader = new FileReader;
        reader.onload = function(e) {
            $('.image-asset-source-preview').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
};
//ImageAssets: preview the uploaded image in new template/tour form
previewImageAssetSource = function () {
    $('.image-asset-source-input').change(function () {
        uploadImageAssetSource(this);
        // add selected file name to input
        $(this).siblings('.label-info').first().html($(this).val());
    });
};

//ButtonActions: toggle input/file based on btn selection(image or text)
buttonActionsBtnTypeChange = function() {
    $('.btn-action-type').change(function(e) {
        var nsf;
        nsf = $(this).closest('.nested-fields');
        btn_src = nsf.find('.btn-action-source');
        btn_label = nsf.find('.btn-action-label');
        if ($(this).val() === '1') {
            btn_src.removeClass('show').fadeIn('slow').addClass('hide');
            btn_label.removeClass('hide').addClass('show').fadeIn('slow');
        } else {
            btn_src.removeClass('hide').addClass('show').fadeIn('slow');
            btn_label.removeClass('show').fadeIn('slow').addClass('hide');
        }
    });
    $('.btn-action-source-input').change(function(e) {
        $(this).siblings('.label-info').first().html($(this).val());
    });
};


$( document ).ready(function() {
    //https://codediode.io/lessons/8736-loading-spinners-in-rails
    //Enable trubolinks prgress indicator
    // Turbolinks.enableProgressBar();
    // Turbolinks progress bar replacement
    NProgress.configure({
        showSpinner: true,
        speed: 500
    });

    // preview the source of image ImageAsset when uploaded 
    previewImageAssetSource(); 
    buttonActionsBtnTypeChange();

    // button disables with loading spinner
    $('.btn-progress').on('click', function() {
        var $this = $(this);
        $this.button('loading');
    });

    // Enable bootstrap default tooltip
    $('[data-toggle="tooltip"]').tooltip({
        trigger : 'hover'
    });


    $('.magnific-popup-img').magnificPopup({
        type:'image'
    });

    $('.magnific-popup-gallery').magnificPopup({
        delegate: 'a', // child items selector, by clicking on it popup will open
        type: 'image',
        gallery: {
            enabled: true
        }
    });

    // fix for tooltip remain on the doc when clicks on 'add more rounded btn'
    $('.btn-circle-mini, .btn-circle-sm, .btn-box-tool').click(function () {
        $(this).blur();
    });




});

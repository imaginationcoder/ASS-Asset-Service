(function($){
    $(function(){

        $('.button-collapse').sideNav();

    }); // end of document ready
})(jQuery); // end of jQuery name space


// below functionality in separate functions because they need to be invoke cocoon callbacks also with document.ready
var uploadImageAssetSource;
var previewImageAssetSource;
var buttonActionsBtnTypeChange;

uploadImageAssetSource = function(input) {
    var reader;
    if (input.files && input.files[0]) {
        reader = new FileReader;
        reader.onload = function(e) {
            $(input).parent('label').siblings('a').first().children('.image-asset-source-preview').attr('src', e.target.result);
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


$(document).ready(function(){
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal-trigger').leanModal();
});

$(document).ready(function(){
    $('ul.tabs').tabs();
});

$(document).ready(function() {
    $('select').material_select();
});

$(document).ready(function() {
    previewImageAssetSource();
    buttonActionsBtnTypeChange();
});

// Turbolinks fetch, change, restore etc..
$(document).on('page:fetch',   function() {
    Pace.restart();
});
$(document).on('page:change',   function() {
    // Pace.restart();
});
$(document).on('page:restore', function() {
    /*spinner.stop(spinner_div);*/
});

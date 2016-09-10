(function($){
    $(function(){

        $('.button-collapse').sideNav();

    }); // end of document ready
})(jQuery); // end of jQuery name space


// below functionality in separate functions because they need to be invoke cocoon callbacks also with document.ready
var uploadImageAssetSource;
var previewImageAssetSource;

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

$(document).ready(function(){
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal-trigger').leanModal();
});

$(document).ready(function(){
    $('ul.tabs').tabs();
});
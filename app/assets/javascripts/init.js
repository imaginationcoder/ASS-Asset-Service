// all common functions goes here
var previewUploadedImage;
previewUploadedImage = function(input) {
    var reader;
    if (input.files && input.files[0]) {
        reader = new FileReader;
        reader.onload = function(e) {
            $('#source-preview').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
};

$( document ).ready(function() {
    //https://codediode.io/lessons/8736-loading-spinners-in-rails
    //Enable trubolinks prgress indicator
    Turbolinks.enableProgressBar();

    // button disables with loading spinner
    $('.btn-progress').on('click', function() {
        var $this = $(this);
        $this.button('loading');
    });

    // Enable bootstrap default tooltip
    $('[data-toggle="tooltip"]').tooltip({
        trigger : 'hover'
    });

    // Home page login, register popups
    $('.popup-with-zoom-anim').magnificPopup({
        type: 'inline',
        fixedContentPos: false,
        fixedBgPos: true,
        overflowY: 'auto',
        closeBtnInside: true,
        preloader: false,
        midClick: true,
        removalDelay: 300,
        mainClass: 'my-mfp-zoom-in'
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
    $('.btn-circle-mini, .btn-circle-sm').click(function () {
        $(this).blur();
    });


});

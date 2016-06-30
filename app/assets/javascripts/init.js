$( document ).ready(function() {
    //Enable trubolinks prgress indicator
    Turbolinks.enableProgressBar();

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

    $('.magnific-popup').magnificPopup({
        type:'image'  
    });

    $('.magnific-popup-gallery').magnificPopup({
        delegate: 'a', // child items selector, by clicking on it popup will open
        type: 'image',
        gallery: {
            enabled: true
        }
    });

});
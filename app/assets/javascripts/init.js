$( document ).ready(function() {
    // $(".dropdown-button").dropdown();
    //Enable trubolinks prgress indicator
    Turbolinks.enableProgressBar();
    $('.button-collapse').sideNav();
    $('.parallax').parallax();
    $(".dropdown-button").dropdown();
    $(".device-dropdown-button").dropdown();

    //$('#modal1').openModal();
    $('.modal-trigger').leanModal();
});
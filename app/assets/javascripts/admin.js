//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require materialize.min
//= require home_init
//= require apps
//= require tour
//= require versions
//= require turbolinks
//= require cocoon

$(document).on('click','.navbar-collapse.in',function(e) {

    if( $(e.target).is('a') && ( $(e.target).attr('class') != 'dropdown-toggle' ) ) {
        $(this).collapse('hide');
    }

});
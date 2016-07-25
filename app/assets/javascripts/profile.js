$(document).ready(function(e) {
    var btn_chane_avatar = $('.form-change-avatar .btn-change-avatar');
    var avatar_file_input = $('.form-change-avatar .input-change-avatar');
    // trigger avatar file input
    btn_chane_avatar.on('click', function(e){
        e.preventDefault();
        avatar_file_input.click();
    });
    // submit from when avatar file input is changed
    avatar_file_input.change(function(){
        btn_chane_avatar.button('loading');
        avatar_file_input.closest(".form-change-avatar").submit();
    });
});

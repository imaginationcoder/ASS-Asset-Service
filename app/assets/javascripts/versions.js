$(document).ready(function() {
    $('.modal-trigger').click(function(e){
        var app_id = $(this).data('app-id'); // Extract info from data-* attributes
        var version_id = $(this).data('version-id');
        var version_number = $(this).data('version-number');

        var modal = $('#version-publish-modal');
        modal.find('.modal-title').text('Publish Version ' + version_number);
        // send ajax request to server onclick of publish now button
        modal.find('.btn-publish-now').on('click', function () {
            var url = "/apps/" + app_id + "/versions/" + version_id + "/publish/";
            var btn = $(this);
            $.post(url, function (data) {
                $("#published-success-modal").find('.published-version').text('Version '+version_number);
            }).done(function() {
                modal.closeModal();
                $("#published-success-modal").openModal();
            }).fail(function() {
                //alert( "error" );
            })
        })
    });
    $("#published-success-modal").find('.btn-done').on('click', function(){
        $("#published-success-modal").closeModal();
        // reload the page
        Turbolinks.visit(window.location.pathname);
    })

});

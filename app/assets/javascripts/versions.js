$(document).ready(function() {
    $('.btn-publish-now').button('reset');
    // fix for dropdown not showing in responsive table
    //$('.table-responsive tbody tr').slice(-2).find('.dropdown').addClass('dropup');
    // open modal when publish action selected
    $('#version-publish-modal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var app_id = button.data('app-id'); // Extract info from data-* attributes
        var version_id = button.data('version-id');
        var version_number = button.data('version-number');
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        modal.find('.modal-title').text('Publish Version ' + version_number);
        // send ajax request to server onclick of publish now button
        modal.find('.btn-publish-now').on('click', function () {
            var url = "/apps/" + app_id + "/versions/" + version_id + "/publish/";
            var btn = $(this);
            $.post(url, function (data) {
                $("#published-success-modal").find('.published-version').text('Version '+version_number);
            }).done(function() {
                btn.button('reset');
                modal.hide();
                $("#published-success-modal").modal();
            }).fail(function() {
                // alert( "error" );
            })
        })
    });

    // unpublish version
    $('.btn-unpublish-now').button('reset');
    // fix for dropdown not showing in responsive table
    //$('.table-responsive tbody tr').slice(-2).find('.dropdown').addClass('dropup');
    // open modal when publish action selected
    $('#version-unpublish-modal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var app_id = button.data('app-id'); // Extract info from data-* attributes
        var version_id = button.data('version-id');
        var version_number = button.data('version-number');
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        modal.find('.modal-title').text('UnPublish Version ' + version_number);
        // send ajax request to server onclick of publish now button
        modal.find('.btn-unpublish-now').on('click', function () {
            var url = "/apps/" + app_id + "/versions/" + version_id + "/unpublish/";
            var btn = $(this);
            $.post(url, function (data) {
                $("#published-success-modal").find('.published-version').text('Version '+version_number);
            }).done(function() {
                btn.button('reset');
                modal.hide();
                Turbolinks.visit(window.location.pathname);
                //$("#published-success-modal").modal();
            }).fail(function() {
                // alert( "error" );
            })
        })
    });

    $("#published-success-modal").find('.btn-done').on('click', function(){
        $("#published-success-modal").modal().hide();
        // reload the page
        Turbolinks.visit(window.location.pathname);
    })

});

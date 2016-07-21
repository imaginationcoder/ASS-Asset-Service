$(document).ready(function() {
    // fix for dropdown not showing in responsive table
    $('.table-responsive tbody tr').slice(-3).find('.dropdown').addClass('dropup');
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
            var btn = $(this)
            $.post(url, function (data) {
                // reload the page after ajax call success
                Turbolinks.visit(window.location.pathname);
            })
            .done(function() {
              // btn.button('reset');
            })
            .fail(function() {
               // alert( "error" );
            })
        })
    });
});

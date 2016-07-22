// Nested  text_assets
function tourNestedTextAssetsCallabacks() {
    $('#templates_fields .text_assets_fields').on('cocoon:before-insert', function(e, to_be_added) {
        to_be_added.fadeIn('slow');
    }).on('cocoon:before-remove', function(e, to_be_removed) {
        e.preventDefault();
        // $(this).data('remove-timeout', 3000);
        to_be_removed.fadeOut(3000);
    }).on('cocoon:after-insert', function(e, added_one) {
       // do whatever
    });
}
// Nested button actions
function tourNestedButtonActionsCallabacks() {
    $('#templates_fields .button_actions_fields').on('cocoon:before-insert', function (e, to_be_added) {
        to_be_added.fadeIn('slow');
    }).on('cocoon:before-remove', function (e, to_be_removed) {
        // $(this).data('remove-timeout', 3000);
        to_be_removed.fadeOut(3000);
    }).on('cocoon:after-insert', function(e, added_one) {
        buttonActionsBtnTypeChange();
    });
}


$(document).ready(function() {
    tourNestedTextAssetsCallabacks();
    tourNestedButtonActionsCallabacks();
    var tour_step;
    tour_step = 1;
    $('#templates_fields').on('cocoon:before-insert', function(e, to_be_added) {
        // https://github.com/almasaeed2010/AdminLTE/issues/592
        // collapse all other boxes
        // check if it has class 'tour-step-box' else nested ones are also executing below
        if(to_be_added.hasClass('tour-step-box')) {
            $('.tour-step-box').each(function(index, obj) {
                var box = $(obj);
                var _this = box.closest('box-header');
                //Find the body and the footer
                var box_content = box.find("> .box-body, > .box-footer");
                var btn_box_tool = box.children(".box-header").children(".box-tools").children('.btn-box-tool').first();
                //Convert minus into plus
                btn_box_tool.children(":first").removeClass('fa-minus').addClass('fa-plus');
                //TODO below not working
                btn_box_tool.data('original-title', 'Expand');
                //Hide the content
                box_content.slideUp(300, function () {
                    box.addClass("collapsed-box");
                });
            });
            //to_be_added.hide();
            to_be_added.fadeIn('slow');
            var box_content = to_be_added.find("> .box-body, > .box-footer");
            var btn_box_tool = to_be_added.children(".box-header").children(".box-tools").children('.btn-box-tool').first();
            btn_box_tool.children(":first").removeClass('fa-plus').addClass('fa-minus');
            //TODO below not working 
            btn_box_tool.data('original-title', 'Collapse');
            //Show the content
            box_content.slideDown(600, function () {
                to_be_added.removeClass("collapsed-box");
            });
        }
    }).on('cocoon:after-insert', function(e, added_one) {
        if(added_one.hasClass('tour-step-box')) {
            // add step number to newly inserted one
            var ns;
            ns = void 0;
            tour_step += 1;
            ns = added_one.closest('.nested-fields');
            ns.find('.tour-step-number').text(tour_step);
        }
        // preview the source of image ImageAsset when uploaded
        previewImageAssetSource();
        buttonActionsBtnTypeChange();
        // invoke nested text and button action's callbacks after-insert
        tourNestedTextAssetsCallabacks();
        tourNestedButtonActionsCallabacks();

    }).on('cocoon:before-remove', function(e, to_be_removed) {
        if(to_be_removed.hasClass('tour-step-box')) {
            $(this).data('remove-timeout', 1000);
            to_be_removed.fadeOut('slow');
        }
    }).on('cocoon:after-remove', function() {
        tour_step -= 1;
        $('.tour-step-number').each(function(index, obj) {
            $(obj).text(index + 1);
        });
    });

});
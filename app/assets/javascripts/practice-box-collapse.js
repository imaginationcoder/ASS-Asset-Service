//Find all steps(boxes) and collpse them
$('.tour-step-box').each(function(index, obj) {
    var box = $(obj);
    var _this = box.closest('box-header');
    //Find the body and the footer
    var box_content = box.find("> .box-body, > .box-footer");
    if (!box.hasClass("collapsed-box")) {
        //Convert minus into plus
        box.children(".box-header").children(".box-tools").children('.btn-box-tool').children(":first")
            .removeClass('fa-minus')
            .addClass('fa-plus');
        //Hide the content
        box_content.slideUp(300, function () {
            box.addClass("collapsed-box");
        });
    } else {
        //Convert plus into minus
        box.children(".box-header").children(".box-tools").children('.btn-box-tool').children(":first")
            .removeClass('fa-plus')
            .addClass('fa-minus');
        //Show the content
        box_content.slideDown(300, function () {
            box.removeClass("collapsed-box");
        });
    }
});
        
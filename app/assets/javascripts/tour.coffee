# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->  
  #COCOON app(tour) nested templates callbacks
  $('#templates_fields').on('cocoon:before-insert', (e, to_be_added) ->
    to_be_added.fadeIn 'slow'
    return
  ).on('cocoon:after-insert', (e, added_one) ->
    # e.g. set the background of inserted task
    # added_one.css("background","red");
    $('.btn-circle-sm').focusout
    $('.btn-circle-sm').blur
    return
  ).on 'cocoon:before-remove', (e, to_be_removed) ->
    # allow some time for the animation to complete
    $(this).data 'remove-timeout', 1000
    to_be_removed.fadeOut 'slow'
    return

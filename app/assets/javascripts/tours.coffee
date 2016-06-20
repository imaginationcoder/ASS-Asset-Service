# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  # set applicatio_id and access in controller
  $('.add-tour-btn').click ->
    $('input[name="tour[app_id]"]').val $(this).data('id')
    return

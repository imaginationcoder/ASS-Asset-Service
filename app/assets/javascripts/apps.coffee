# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/  
$(document).ready ->
  # preview the uploaded image in new prePrompt form
  $('#new_app #app_logo').change ->
    previewUploadedImage this
    $(this).siblings('.label-info').first().html $(this).val()
    return

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# to preview the uploaded Image
previewUploadedImage = (input) ->
  if input.files and input.files[0]
    reader = new FileReader 
    reader.onload = (e) ->
      $('#source-preview').attr 'src', e.target.result
      return 
    reader.readAsDataURL input.files[0]
  return 
 
$(document).ready ->
  # preview the uploaded image in new prePrompt form
  $('#new_template #template_source').change -> 
    previewUploadedImage this 
    return

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
prePromptButtonActionChange = ->
  $('.nested_pre_prompt_button_actions .button-action-type').change (e) ->
    # find parent and hide all groups first then show the group which sibling to clicked radio btn
    $div = $(this).closest('.nested_fields')
    $div.find('.btn-controls').removeClass 'show'
    $div.find('.btn-controls').addClass 'hide'
    $(this).closest('.row').nextAll('div.row').first().addClass 'show'
    return
  return

# to preview the uploaded Image
previewUploadedImage = (input) ->
  if input.files and input.files[0]
    reader = new FileReader

    reader.onload = (e) ->
      $('#source-preview').attr 'src', e.target.result
      return

    reader.readAsDataURL input.files[0]
  return

# invoke button action type change on nested attribute changes
$(document).on 'fields_added.nested_form_fields', (event, param) ->
  prePromptButtonActionChange()
  return

$(document).ready ->
  prePromptButtonActionChange()
  # preview the uploaded image in new prePrompt form
  $('#new_pre_prompt #pre_prompt_source').change ->
    previewUploadedImage this
    $('#source-preview').closest('.col-sm-6').addClass 'show'
    return


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
templateButtonActionTypeChange = ->
  #Template ButtonAction: when btn-action-type is changed(hide label field if its a image vice versa..)
  $('.btn-action-type').change (e) ->
    $div = $(this).closest('.nested-fields')
    if $(this).val() == '1'
      $div.find('.btn-action-source').removeClass('show').fadeIn 'slow'
      $div.find('.btn-action-source').addClass 'hide'
      $div.find('.btn-action-label').removeClass 'hide'
      $div.find('.btn-action-label').addClass('show').fadeIn 'slow'
    else
      $div.find('.btn-action-source').removeClass 'hide'
      $div.find('.btn-action-source').addClass('show').fadeIn 'slow'
      $div.find('.btn-action-label').removeClass('show').fadeIn 'slow'
      $div.find('.btn-action-label').addClass 'hide'
    return
  # Template button action when image selected then add the filename to styled file input btn
  $('.btn-action-source-input').change (e) ->
    $(this).siblings('.label-info').first().html $(this).val()
    return
  return  
 
$(document).ready ->
  templateButtonActionTypeChange()
  # preview the uploaded image in new prePrompt form
  $('#new_template #template_source').change -> 
    previewUploadedImage this 
    return

  #COCOON template nested text assets callbacks
  $('#text_assets_fields').on('cocoon:before-insert', (e, to_be_added) ->
    to_be_added.fadeIn 'slow'
    return
  ).on('cocoon:after-insert', (e, added_one) ->
    # e.g. set the background of inserted task
    # added_one.css("background","red");
    return
  ).on 'cocoon:before-remove', (e, to_be_removed) ->
    # allow some time for the animation to complete
    $(this).data 'remove-timeout', 1000
    to_be_removed.fadeOut 'slow'
    return

  #COCOON template nested button actions callbacks
  $('#button_actions_fields').on('cocoon:before-insert', (e, to_be_added) ->
    to_be_added.fadeIn 'slow'
    return
  ).on('cocoon:after-insert', (e, added_one) ->
    # e.g. set the background of inserted task
    # added_one.css("background","red");
    templateButtonActionTypeChange()
    return
  ).on 'cocoon:before-remove', (e, to_be_removed) ->
    # allow some time for the animation to complete
    $(this).data 'remove-timeout', 1000
    to_be_removed.fadeOut 'slow'
    return
  return 
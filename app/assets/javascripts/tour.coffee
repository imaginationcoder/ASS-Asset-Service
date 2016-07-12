# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->  
  # COCOON app(tour) nested templates callbacks
  tour_step = 1
  $('#templates_fields').on('cocoon:before-insert', (e, to_be_added) ->
    to_be_added.fadeIn 'slow'
    return
  ).on('cocoon:after-insert', (e, added_one) ->
    ns = undefined
    $('.btn-circle-sm').focusout
    $('.btn-circle-sm').blur
    tour_step += 1
    ns = added_one.closest('.nested-fields')
    # Update Tour Step Number
    ns.find('.tour-step-number').text tour_step
    return
  ).on('cocoon:before-remove', (e, to_be_removed) ->
    $(this).data 'remove-timeout', 1000
    to_be_removed.fadeOut 'slow'
    return
  ).on 'cocoon:after-remove', ->
    tour_step -= 1
    # Reset Tour stpe number by looping through with class name
    $('.tour-step-number').each (index, obj) ->
      $(obj).text index+1
      return
    return


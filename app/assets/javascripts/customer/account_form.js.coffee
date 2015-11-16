$(document).on 'page:change', ->
  return if $('div.confirming').length
  toggle_home_address_fields()
  toggle_work_address_fields()
  $('input#form_inputs_home_address').on 'click', ->
    toggle_home_address_fields()
  $('input#form_inputs_work_address').on 'click', ->
    toggle_work_address_fields()

toggle_home_address_fields = ->
  checked = $('input#form_inputs_home_address').prop('checked')
  $('fieldset#home-address-fields input').prop('disabled', !checked)
  $('fieldset#home-address-fields select').prop('disabled', !checked)
  $('fieldset#home-address-fields').toggle(checked)

toggle_work_address_fields = ->
  checked = $('input#form_inputs_work_address').prop('checked')
  $('fieldset#work-address-fields input').prop('disabled', !checked)
  $('fieldset#work-address-fields select').prop('disabled', !checked)
  $('fieldset#work-address-fields').toggle(checked)

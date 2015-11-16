$(document).on 'page:change', ->
  $('form.edit_staff_member').on 'click', '#enable-password-field', ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#staff_member_password').removeAttr('disabled')
    $('label[for=staff_member_password]').addClass('required')
  $('form.edit_staff_member').on 'click', '#disable-password-field', ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#staff_member_password').attr('disabled', 'disabled')
    $('label[for=staff_member_password]').removeClass('required')

$(document).on 'page:change', ->
  $('.birthday-picker').datepicker({
    minDate: new Date(1900, 1, 1),
    maxDate: new Date(),
    changeMonth: true,
    changeYear: true,
    yearRange: '1900:+00',
    defaultDate: '1970-01-01'
  })

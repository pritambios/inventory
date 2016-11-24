$(function() {
  $(".alert" ).fadeOut(3000);
  $('.datepicker').datetimepicker({ format: 'DD/MM/YYYY' });
});

$(document).on('change', "#checkout_item_id", function() {
  var selected = $(this).find('option:selected');
  $('#checkout_checkout').data('DateTimePicker').minDate(moment(selected.data('purchase-on'), 'YYYY MM DD'));
});

$(document).on('change', "#issue_item_id", function() {
  var selected = $(this).find('option:selected');
  $('#issue_closed_at').data('DateTimePicker').minDate(moment(selected.data('purchase-on'), 'YYYY MM DD'));
});

$(document).on('change', "#issue_system_id", function() {
  var selected = $(this).find('option:selected');
  $('#issue_closed_at').data('DateTimePicker').minDate(moment(selected.data('assembled_on'), 'YYYY MM DD'));
});

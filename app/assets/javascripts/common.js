$(function() {
  $(".alert" ).fadeOut(3000);
  $('.datepicker').datetimepicker({ format: 'DD/MM/YYYY' });
});

$(document).on('change', '.brand-dropdown,.category-dropdown', function() {
  $(this).parent().submit();
});

$(document).on('change', '.change-parent', function() {
  $.ajax({
    type: "GET",
    url: '/items/'+ $(".change-parent").val() +'/item_render/'
  });
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

$.fn.datetimepicker.defaults.icons = {
  time: 'fa fa-clock-o',
  date: 'fa fa-calendar',
  up: 'fa fa-chevron-up',
  down: 'fa fa-chevron-down',
  previous: 'fa fa-chevron-left',
  next: 'fa fa-chevron-right',
  today: 'fa fa-dot-circle-o',
  clear: 'fa fa-trash',
  close: 'fa fa-times'
};

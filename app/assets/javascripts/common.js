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

$(document).on('show.bs.modal', '#attachmentModal', function(event){
  var button = $(event.relatedTarget);
  var url = button.data('url');
  if (button.data('type').match(/image|pdf/)) {
    $("#attachment").show();
    $("#attachment").attr('data', url);
  }
  else {
    $("#attachment").hide();
    $("#attachment-without-preview a").attr("href", url)
  }
});

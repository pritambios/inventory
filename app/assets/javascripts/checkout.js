$('#checkout_item_id').change(function() {
  var selected = $(this).find('option:selected');
  var purchase_on = selected.data('purchase_on');
  console.log(purchase_on);
  $('#checkout_checking_out').datepicker({ startDate: purchase_on });
});

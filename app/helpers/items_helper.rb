module ItemsHelper
  def allocation_type(item)
    item.employee_id.present? ? t('button.reallocate_deallocate') : t('button.item_allocate')
  end

  def checkout_details(item)
    value = "for #{item.pending_checkout.reason} on #{format_date(item.pending_checkout.checkout)}"

    if item.pending_checkout.employee_id.present?
      value += " by #{item.pending_checkout.employee.name}"
    end

    value
  end

  def admin_items_list
    options_for_select(Item.not_erased.active.available.sort_by(&:name).map{ |i| [i.name_with_id, i.id, { 'data-purchase-on' => i.purchase_on }] }, selected: @issue.item_id)
  end

  def employee_items_list
    options_for_select(current_employee.items.not_erased.active.sort_by(&:name).map{ |i| [i.name_with_id, i.id, { 'data-purchase-on' => i.purchase_on }] }, selected: @issue.item_id)
  end
end

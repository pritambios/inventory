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
end

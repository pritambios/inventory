module ItemsHelper
  def allocation_type(item)
    item.employee_id.present? ? 'Reallocate / Deallocate' : 'Allocate'
  end

  def checkout_details(item)
    value = "for #{item.pending_checkout.reason} on #{format_date(item.pending_checkout.checkout)}"

    if item.pending_checkout.employee_id.present?
      value += " by #{item.pending_checkout.employee.name}"
    end

    value
  end

  def name_with_id(item)
    "#{item.name} #{item.id}"
  end

  def working_status(item)
    item.working ? 'Working' : 'Non Working'
  end
end

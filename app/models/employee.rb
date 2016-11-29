class Employee
  include Her::Model

  def items
    Item.where(employee_id: id)
  end

  def systems
    System.where(employee_id: id)
  end

  def system_histories
    SystemHistory.where(employee_id: id)
  end

  def item_histories
    ItemHistory.where(employee_id: id)
  end

  def checkouts
    Checkout.where(employee_id: id)
  end

  scope :particular_company, -> { where(company_id: 1) }
end

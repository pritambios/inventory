class Employee
  include Her::Model

  scope :company_employees, -> { where(company_id: Rails.application.config.company_id).all }

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
end

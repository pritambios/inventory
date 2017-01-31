class ExternalEmployee
  include Her::Model
  collection_path "employees"

  scope :company_employees, -> { where(company_id: Rails.application.config.company_id).all }

  def checkouts
    Checkout.where(employee_id: id)
  end

  def items
    Item.where(employee_id: id)
  end

  def item_histories
    ItemHistory.where(employee_id: id)
  end
end

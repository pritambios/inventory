class SystemHistory < ApplicationRecord
  belongs_to :system

  scope :order_desending, -> { order('created_at DESC') }

  def employee
    if employee_id.present?
      Employee.find(employee_id, { company_id: '1' })
    end
  end
end

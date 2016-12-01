class SystemHistory < ApplicationRecord
  belongs_to :system

  scope :order_desending, -> { order('created_at DESC') }

  def employee
    Employee.find(employee_id, { company_id: Rails.application.config.company_id }) if employee_id.present?
  end
end

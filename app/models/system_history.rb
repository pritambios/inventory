class SystemHistory < ActiveRecord::Base
  belongs_to :system

  validates :system, presence: true
  scope :order_desending, -> { order('created_at DESC') }

  def employee
    Employee.find(employee_id, { company_id: Rails.application.config.company_id }) if employee_id.present?
  end
end

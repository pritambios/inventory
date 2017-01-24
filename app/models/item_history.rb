class ItemHistory < ActiveRecord::Base
  belongs_to :employee
  belongs_to :item
  belongs_to :parent, class_name: "Item"

  validates :item, presence: true
  validates :note, length: { maximum: 500 }

  scope :order_desending, -> { order('created_at DESC') }

  def employee
    Employee.find(employee_id, { company_id: Rails.application.config.company_id }) if employee_id.present?
  end
end

class ItemHistory < ApplicationRecord
  belongs_to :item
  belongs_to :system, optional: true

  validates :note, length: { maximum: 500 }

  scope :order_desending, -> { order('created_at DESC') }

  def employee
    if employee_id.present?
      Employee.find(employee_id, { company_id: '1' })
    end
  end
end

class Checkout < ApplicationRecord
  belongs_to :item

  validates :checkout, presence: true
  validates :reason, presence: true
  validate  :checkout_limitation

  scope :order_desending, -> { order('created_at DESC') }
  scope :pending,         -> { where(check_in: nil) }

  def employee
    if employee_id.present?
      Employee.find(employee_id, { company_id: '1' })
    end
  end

  def checkin?
    check_in.present?
  end

  private

  def checkout_limitation
    errors.add(:checkout, "must be after purchase date") unless checkout > self.item.purchase_on
  end
end

class Checkout < ApplicationRecord
  belongs_to :item

  validates :checkout, presence: true
  validates :reason, presence: true
  validate  :checkout_limitation

  scope :order_desending, -> { order('created_at DESC') }
  scope :pending,         -> { where(check_in: nil) }

  def checkin?
    check_in.present?
  end

  def employee
    Employee.find(employee_id, { company_id: Rails.application.config.company_id }) if employee_id.present?
  end

  private

  def checkout_limitation
    errors.add(:checkout, "must be after purchase date") unless checkout > self.item.purchase_on
  end
end

class Checkout < ActiveRecord::Base
  belongs_to :employee
  belongs_to :item

  validates :item, :checkout, :reason, :employee, presence: true
  validate  :checkout_limitation

  scope :order_desending, -> { order('created_at DESC') }
  scope :pending,         -> { where(check_in: nil) }

  def checkin?
    check_in.present?
  end

  private

  def checkout_limitation
    if item.purchase_on.present?
      errors.add(:checkout, "must be after purchase date") unless checkout >= item.purchase_on
    end
  end
end

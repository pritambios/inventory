class Checkout < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :item

  validates :checkout, presence: true
  validates :reason, presence: true
  validate  :checkout_limitation

  scope :order_desending, -> { order('created_at DESC') }

  def checkin?
    check_in.present?
  end

  private

  def checkout_limitation
    errors.add(:checkout, "must be after purchase date") unless checkout > self.item.purchase_on
  end
end

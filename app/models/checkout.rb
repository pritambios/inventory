class Checkout < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :item

  validates :checking_out, presence: true
  validates :reason, presence: true
  validate  :checkout_limitation

  scope :order_desending, -> { order('created_at DESC') }

  private

  def checkout_limitation
    errors.add(:checking_out, "must be after purchase date") unless checking_out > self.item.purchase_on
  end
end

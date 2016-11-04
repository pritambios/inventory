class Checkout < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :item, optional: true

  validates :checking_out, presence: true
  validates :reason, presence: true

  scope :order_desending, -> { order('created_at DESC') }
end

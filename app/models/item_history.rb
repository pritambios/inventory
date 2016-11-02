class ItemHistory < ApplicationRecord
  belongs_to :item
  belongs_to :employee, optional: true
  belongs_to :system, optional: true

  validates :note, length: { maximum: 500 }

  scope :order_desending, -> { order('created_at DESC') }
end

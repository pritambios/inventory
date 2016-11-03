class SystemHistory < ApplicationRecord
  belongs_to :system
  belongs_to :employee

  scope :order_desending, -> { order('created_at DESC') }
end

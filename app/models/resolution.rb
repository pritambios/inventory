class Resolution < ApplicationRecord
  has_many :issues

  validates :name, presence: true

  scope :order_asssending, -> { order('name') }
end

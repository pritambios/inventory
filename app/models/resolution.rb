class Resolution < ApplicationRecord
  has_many :issues

  validates :name, presence: true

  scope :order_by_name, -> { order('name') }
end

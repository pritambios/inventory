class Vendor < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :address, presence: true

  scope :order_by_name, -> { order('name') }
end

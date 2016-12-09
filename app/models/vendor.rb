class Vendor < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :address, presence: true

  scope :order_asssending, -> { order('name') }
end

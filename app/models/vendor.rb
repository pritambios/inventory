class Vendor < ActiveRecord::Base
  has_many :items

  validates :address, :name, presence: true

  scope :order_by_name, -> { order('name') }
end

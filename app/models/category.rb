class Category < ActiveRecord::Base
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: true }, length: { maximum: 25 }
  validates_uniqueness_of :name

  scope :order_by_name, -> { order('name') }
end

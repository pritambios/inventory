class Brand < ActiveRecord::Base
  has_many :items

  validates :name, presence: true, uniqueness: {case_sensitive: true }, length: { maximum: 25 }
  validates_uniqueness_of :name

  scope :active,        -> { where(deleted_at: nil) }
  scope :order_by_name, -> { order('name') }

  def category_count
    items.group("category").count.map{|k,v| "#{k.name}-#{v}"}.join(", ")
  end
end

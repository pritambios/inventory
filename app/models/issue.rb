class Issue < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :system, optional: true
  belongs_to :resolution, optional: true

  validates :title, presence: true
  validate  :closed_at_limitation

  scope :order_desending, -> { order('created_at DESC') }
  scope :unclosed,        -> { where(closed_at: nil) }

  def closed_at_limitation
    errors.add(:closed_at, "must be after purchase date") unless closed_at > self.item.purchase_on
  end
end

class Issue < ApplicationRecord
  enum priority: [:high, :medium, :low, :as_soon_as_possible]

  belongs_to :item
  belongs_to :resolution
  belongs_to :employee

  validates :title, :item, presence: true
  validate  :item_closed_at_limitation

  delegate :name, to: :employee, prefix: true

  scope :order_descending, -> { order('created_at DESC') }
  scope :unclosed, -> { where(closed_at: nil) }

  def item_closed_at_limitation
    if closed_at.present? && item.present? && item.purchase_on.present?
      errors.add(:closed_at, "must be after item purchase date") unless closed_at >= item.purchase_on
    end
  end
end

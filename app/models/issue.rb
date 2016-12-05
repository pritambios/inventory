class Issue < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :system, optional: true
  belongs_to :resolution, optional: true

  validates :title, presence: true
  validate  :item_or_system_presence
  validate  :item_closed_at_limitation
  validate  :system_closed_at_limitation

  scope :order_desending, -> { order('created_at DESC') }
  scope :unclosed,        -> { where(closed_at: nil) }

  enum priority: [:high, :medium, :low, :as_soon_as_possible]

  def item_or_system_presence
    unless [item, system].any?
      errors.add :base, 'Item / System must be present!'
    end
  end

  def item_closed_at_limitation
    if closed_at.present? and item.present?
      errors.add(:closed_at, "must be after item purchase date") unless closed_at > item.purchase_on
    end
  end

  def system_closed_at_limitation
    if closed_at.present? and system.present?
      errors.add(:closed_at, "must be after system assembled date") unless closed_at > system.assembled_on
    end
  end
end

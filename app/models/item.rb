class Item < ApplicationRecord
  around_save :update_item_history

  has_many :item_histories
  has_many :checkouts
  has_many :issues

  belongs_to :employee, optional: true
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :system, optional: true
  belongs_to :vendor, optional: true

  validates :serial_number, presence: true, length: { minimum: 3, maximum: 50 }
  validates :purchase_on, presence: true

  scope :order_desending, -> { order('created_at DESC') }

  def name
    "#{brand.try(:name)} #{category.name}"
  end

  scope :unavailable, -> { joins(:checkouts).where(checkouts: { check_in: nil }) }
  scope :available,   -> { where.not(id: unavailable) }
  scope :unattached,   -> { where(system_id: nil) }

  private

  def update_item_history
    if system_id_changed? || employee_id_changed? || working_changed? || new_record?
      item_history = item_histories.build(employee_id: employee_id, system_id: system_id, status: working)
    end

    yield

    item_history.save if item_history.present?
  end
end

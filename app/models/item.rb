class Item < ApplicationRecord
  around_save :update_item_history

  has_many :item_histories
  has_many :checkouts
  has_many :issues
  has_many :documents, inverse_of: :item

  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :system, optional: true
  belongs_to :vendor, optional: true

  validates :serial_number, presence: true, length: { minimum: 3, maximum: 50 }

  accepts_nested_attributes_for :documents

  scope :order_desending, -> { order('created_at DESC') }
  scope :unavailable, -> { joins(:checkouts).where(checkouts: { check_in: nil }) }
  scope :available,   -> { where.not(id: unavailable) }
  scope :unattached,  -> { where(system_id: nil) }
  scope :active,      -> { where(discarded_at: nil) }
  scope :discarded,  -> { where.not(discarded_at: nil) }

  def name
    "#{brand.try(:name)} #{category.name}"
  end

  def employee
    Employee.find(employee_id, { company_id: Rails.application.config.company_id }) if employee_id.present?
  end

  def unavailable?
    checkouts.map(&:checkin?).include? false
  end

  def pending_checkout
    checkouts.pending.order_desending.first
  end

  private

  def update_item_history
    if system_id_changed? || employee_id_changed? || working_changed? || new_record?
      item_history = item_histories.build(employee_id: employee_id, system_id: system_id, status: working)
    end

    yield

    item_history.save if item_history.present?
  end
end

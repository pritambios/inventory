class Item < ApplicationRecord
  after_save :update_item_history
  has_many :item_histories
  belongs_to :employee, optional: true
  belongs_to :category
  belongs_to :brand
  belongs_to :system, optional: true

  validates :serial_number, presence: true, length: { minimum: 3, maximum: 50 }
  validates :model_number, presence: true, length: { minimum: 2, maximum: 25 }
  validates :purchase_on, presence: true
  validates :purchase_from, presence: true

  def name
    "#{brand.name}-#{category.name}_#{serial_number}"
  end

  private

  def update_item_history
    if system_id_changed? || employee_id_changed? || working_changed?
      item_history = item_histories.build(employee_id: employee_id, system_id: system_id, status: working)
      item_history.save
    end
  end

  def save_allocation_history(user)
    allocation_history = allocation_histories.build
    allocation_history.user_id = user.id
    allocation_history.status = "reallocated"
    allocation_history.save
  end

  def save_deallocation_history(user)
    allocation_history = allocation_histories.build
    allocation_history.user_id = user.id
    allocation_history.status = "deallocated"
    allocation_history.save
  end
end

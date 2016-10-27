class Item < ApplicationRecord
  belongs_to :employee
  belongs_to :category
  belongs_to :brand
  belongs_to :system

  validates :serial_number, presence: true, length: { minimum: 3, maximum: 50 }
  validates :model_number, presence: true, length: { minimum: 2, maximum: 25 }
  validates :purchase_on, presence: true
  validates :purchase_from, presence: true

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

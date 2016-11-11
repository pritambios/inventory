class System < ActiveRecord::Base
  around_save :update_system_history

  has_many :items
  has_many :system_histories
  has_many :issues

  belongs_to :employee, optional: true

  validates :assembled_on, presence: true

  scope :order_desending, -> { order('created_at DESC') }

  def name
    "System #{id}"
  end

  def associable_items
    Item.available.unattached.to_a.concat(items)
  end

  def update_system_history
    if employee_id_changed? || working_changed? || new_record?
      system_history = system_histories.build(employee_id: employee_id, status: working)
    end

    yield

    system_history.save if system_history.present?
  end
end

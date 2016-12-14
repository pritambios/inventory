class System < ApplicationRecord
  after_save :assign_items_to_employee
  around_save :update_system_history

  has_many :issues
  has_many :items
  has_many :system_histories

  validates :assembled_on, presence: true

  scope :order_desending, -> { order('created_at DESC') }

  def assign_items_to_employee
    if employee_id.present?
      items.each do |item|
        item.employee_id = employee_id
        item.save
      end
    end
  end

  def associable_items
    Item.available.unattached.to_a.concat(items)
  end

  def employee
    Employee.find(employee_id, { company_id: Rails.application.config.company_id }) if employee_id.present?
  end

  def item_ids=(arg)
    items.where(id: item_ids - arg.map(&:to_i)).update_all(employee_id: nil, system_id: nil)

    super(arg)
  end

  def name
    "System #{id}"
  end

  def update_system_history
    if employee_id_changed? || working_changed? || new_record?
      system_history = system_histories.build(employee_id: employee_id, status: working)
    end

    yield

    system_history.save if system_history.present?
  end
end

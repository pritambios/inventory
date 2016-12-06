class System < ActiveRecord::Base
  around_save :update_system_history
  after_save :assign_items_to_employee

  has_many :items
  has_many :system_histories
  has_many :issues

  validates :assembled_on, presence: true

  scope :order_desending, -> { order('created_at DESC') }

  def item_ids=(arg)
    items.each do |item|
      item.employee_id = nil
      item.save!
    end
    super(arg)
  end

  def name
    "System #{id}"
  end

  def employee
    Employee.find(employee_id, { company_id: Rails.application.config.company_id }) if employee_id.present?
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

  def assign_items_to_employee
    if employee_id_changed?
      items.each do |item|
        item.employee_id = employee_id
        item.save
      end
    end
  end
end

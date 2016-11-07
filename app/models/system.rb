class System < ActiveRecord::Base
  around_save :update_system_history

  has_many :items
  has_many :system_histories
  has_many :issues

  belongs_to :employee, optional: true

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

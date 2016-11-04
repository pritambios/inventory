class System < ActiveRecord::Base
  after_save :update_system_history

  has_many :items
  has_many :system_histories
  has_many :issues

  belongs_to :employee, optional: true

  def name
    "System #{id}"
  end

  def update_system_history
    if employee_id_changed? || working_changed?
      system_history = system_histories.build(employee_id: employee_id, status: working)
      system_history.save
    end
  end
end

class System < ActiveRecord::Base
  has_many :items
  belongs_to :employee

  validates :employee_id, presence: true
end

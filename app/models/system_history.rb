class SystemHistory < ActiveRecord::Base
  belongs_to :employee
  belongs_to :system

  validates :system, presence: true
  scope :order_desending, -> { order('created_at DESC') }
end

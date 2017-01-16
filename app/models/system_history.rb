class SystemHistory < ActiveRecord::Base
<<<<<<< HEAD
  belongs_to :employee
  belongs_to :system
=======
  belongs_to :item
>>>>>>> Removed system id from all tables

  validates :item, presence: true
  scope :order_desending, -> { order('created_at DESC') }
end

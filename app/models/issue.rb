class Issue < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :system, optional: true
  belongs_to :resolution, optional: true

  validates :title, presence: true

  scope :order_desending, -> { order('created_at DESC') }
end

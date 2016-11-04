class Issue < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :system, optional: true

  validates :title, presence: true
end

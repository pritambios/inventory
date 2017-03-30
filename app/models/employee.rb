class Employee < ActiveRecord::Base
  has_many :items, dependent: :nullify
  has_many :item_histories, dependent: :nullify
  has_many :checkouts, dependent: :nullify
  has_many :issues, dependent: :nullify

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: User::VALID_EMAIL_REGEX }, allow_blank: true

  before_save :deallocate_items

  scope :order_by_name, -> { order('name') }

  def deallocate_items
    items.clear() if active_changed? && active == false
  end
end

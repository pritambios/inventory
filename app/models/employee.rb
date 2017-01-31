class Employee < ActiveRecord::Base
  has_many :items, dependent: :nullify
  has_many :item_histories, dependent: :nullify
  has_many :checkouts, dependent: :nullify

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: User::VALID_EMAIL_REGEX }, allow_blank: true

  scope :order_by_name, -> { order('name') }
end

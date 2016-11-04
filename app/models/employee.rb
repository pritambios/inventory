class Employee < ActiveRecord::Base
  has_many :systems
  has_many :items
  has_many :system_histories

  has_many :checkouts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :designation, presence: true
end

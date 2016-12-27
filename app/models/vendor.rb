class Vendor < ActiveRecord::Base
  VALID_MOBILE_REGEX = /\A\+?\d+\-?\d+\z/

  has_many :items

  validates :address, :name, presence: true
  validates :mobile, length: { minimum: 10, maximum: 15}, format: { with: VALID_MOBILE_REGEX }, allow_blank: true
  validates :email, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: User::VALID_EMAIL_REGEX }, allow_blank: true

  scope :order_by_name, -> { order('name') }
end

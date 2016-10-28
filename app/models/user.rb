class User < ApplicationRecord

  has_many :items, dependent: :destroy
  has_many :allocation_histories

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false },
 			      format: { with: VALID_EMAIL_REGEX }

  def full_name
   return "#{first_name} #{last_name}".strip if(first_name || last_name)
   "Anonymous"
 end
end

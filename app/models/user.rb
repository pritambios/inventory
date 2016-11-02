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

  def self.find_or_create_from_auth(auth)
    user = User.find_or_initialize_by(email: auth.info.email)
    user.google_uid = auth.uid
    user.email = auth.info.email
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.access_token = auth.credentials.token
    user.save!
    user
  end
end

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :items

  before_save { self.email = email.downcase }

  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

  scope :order_by_name, -> { order('first_name') }

  def full_name
    "#{first_name} #{last_name}".squish
  end

  def name_or_email
    full_name.presence || email
  end

  def update_from_auth(auth)
    self.first_name   = auth.info.name.split.first
    self.last_name    = auth.info.name.split.last
    self.google_uid   = auth.uid
    self.access_token = auth.credentials.token

    save!
  end
end

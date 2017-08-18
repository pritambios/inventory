class Employee < ActiveRecord::Base
  STATUS = { Active: "active", Inactive: "inactive" }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :items, dependent: :nullify
  has_many :item_histories, dependent: :nullify
  has_many :checkouts, dependent: :nullify
  has_many :issues, dependent: :nullify

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  before_save :deallocate_items

  scope :order_by_name, -> { order('name') }
  scope :active,        -> { where(active: true) }
  scope :inactive,      -> { where(active: false) }

  def name_or_email
    name.presence || email
  end

  def deallocate_items
    items.clear() if active_changed? && active == false
  end

  def update_from_auth(auth)
    self.name         = auth.info.name
    self.google_uid   = auth.uid
    self.access_token = auth.credentials.token
    save!
  end

  def self.filter_by_status(status)
    if STATUS.has_key?(status.to_sym)
      send(STATUS[status.to_sym])
    else
      all
    end
  end
end

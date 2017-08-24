class Document < ActiveRecord::Base
  belongs_to :item

  has_attached_file :attachment
  validates :item, presence: true
  validates_attachment :attachment, content_type: { content_type: %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end

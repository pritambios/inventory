class Document < ApplicationRecord
  belongs_to :item

  has_attached_file :attachment

  validates_attachment :attachment, content_type: { content_type: %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end

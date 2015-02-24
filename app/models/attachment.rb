class Attachment < ActiveRecord::Base
  mount_base64_uploader :file, FileUploader

  belongs_to :task, inverse_of: :attachments

  validates :file, presence: true
  validates :task, presence: true, associated: true
end

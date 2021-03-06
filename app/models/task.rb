class Task < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy, inverse_of: :task

  acts_as_list scope: :user

  acts_as_taggable

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true
  validates :body,  presence: true
  validates :user,  presence: true, associated: true
end

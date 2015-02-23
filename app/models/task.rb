class Task < ActiveRecord::Base
  belongs_to :user
  acts_as_list scope: :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true, associated: true
end

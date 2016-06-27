class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  before_validation do
    self.uid = email if uid.blank?
  end

  has_many :tasks, -> { order("position ASC") }, dependent: :destroy
end

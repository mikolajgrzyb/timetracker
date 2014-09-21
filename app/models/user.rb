class User < ActiveRecord::Base

 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :members
  has_many :accounts, through: :members

  mount_uploader :avatar, AvatarUploader
end

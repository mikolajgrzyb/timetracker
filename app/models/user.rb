class User < ActiveRecord::Base

 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :members
  has_many :accounts, through: :members

  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}

  mount_uploader :avatar, AvatarUploader
end

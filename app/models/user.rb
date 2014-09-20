class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :account, foreign_key: 'owner_id'
  has_many :account_members
  has_many :memberships, through: :account_members, source: :account
end

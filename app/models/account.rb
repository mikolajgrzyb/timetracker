class Account < ActiveRecord::Base
  has_many :members
  has_many :users, through: :members
  has_many :invitations
  has_many :projects

  validates :company_name, presence: true

end

class Account < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :account_members
  has_many :members, through: :account_members, class_name: 'User'

  validates :company_name, uniqueness: true

end
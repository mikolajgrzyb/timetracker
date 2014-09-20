class Account < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :account_members
  has_many :members, throught: :account_members, class_name: 'User'

end
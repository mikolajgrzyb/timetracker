class Account < ActiveRecord::Base
  has_many :members
  has_many :users, through: :members

  validates :company_name, presence: true

end

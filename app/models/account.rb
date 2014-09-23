class Account < ActiveRecord::Base
  extend FriendlyId

  has_many :members
  has_many :users, through: :members
  has_many :invitations
  has_many :projects

  friendly_id :company_name, use: [:slugged, :finders]
end

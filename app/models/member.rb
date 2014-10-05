class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :account

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  enum role: [ :regular, :admin, :owner ]
end

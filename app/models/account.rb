class Account < ActiveRecord::Base
  extend FriendlyId
  friendly_id :company_name, use: :slugged

  belongs_to :owner, class_name: 'User'
  has_many :account_members
  has_many :members, through: :account_members, source: :user, class_name: 'User', foreign_key: 'user_id'

  before_create :set_token

  validates :owner_id, presence: true

  private

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end

end
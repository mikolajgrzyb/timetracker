class Account < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :account_members
  has_many :members, through: :account_members, class_name: 'User'

  before_create :set_token

  validates :company_name, uniqueness: true

  private

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end

end
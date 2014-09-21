class Account < ActiveRecord::Base
  has_many :members
  has_many :users, through: :members

  before_create :set_token

  validates :company_name, presence: true

  private

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end

end

class Invitation < ActiveRecord::Base
  belongs_to :account

  before_create :set_token

  private

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end
end

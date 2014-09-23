class Invitation < ActiveRecord::Base
  belongs_to :account
  belongs_to :inviter, class_name: 'User'

  before_create :set_token

  private

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end
end

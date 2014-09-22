module RegistrationValidation
  include ActiveSupport::Concern
  include ActiveModel::Model

  attr_accessor :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :uniq_email

  private

  def uniq_email
    errors.add(:email, 'Email must be uniq') if !(user.email.downcase == @params[:email].downcase) && User.exists?(id: @params[:user_id], email: email)
  end
end

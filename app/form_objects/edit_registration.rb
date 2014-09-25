class EditRegistration
  include ActiveModel::Model

  attr_accessor :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  validate :uniq_email
  validates :password, length: { minimum: 6 }, confirmation: true, unless: -> { password.blank? }
  validates :password_confirmation, presence: true, unless: -> { password.blank? }

  def initialize(options = {})
    @user = options[:user]
    @params = options[:params]
    assign_attributes if @params
  end

  def persisted?
    true
  end

  def update
    if valid?
      ActiveRecord::Base.transaction do
        update_user
      end
    end
  end

  private

  def assign_attributes
    @first_name = @params.fetch(:first_name, @user.first_name)
    @last_name = @params.fetch(:last_name, @user.last_name)
    @email = @params.fetch(:email, @user.email)
  end

  def update_user
    @user.update_attributes user_params
    user.save!(validate: false)
  end

  def user_params
    {
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password
    }.except(:password) unless password.present?
  end

  def uniq_email
    errors.add(:email, 'must be unique') if User.exists?(email: email.try(:downcase)) && (@params[:email].try(:downcase) != @user.email.downcase)
  end
end

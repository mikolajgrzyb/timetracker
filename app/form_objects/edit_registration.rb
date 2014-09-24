class EditRegistration
  include ActiveModel::Model

  attr_accessor :user

  delegate :first_name, :last_name, :email, :password, :password_confirmation, to: :user

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
        user.save!
      end
    end
  end

  private

  def assign_attributes
    @user.assign_attributes user_params
  end

  def user_params
    if @params[:password].present?
      @params.slice(:first_name, :last_name, :avatar, :email, :password, :password_confirmation)
    else
      @params.slice(:first_name, :last_name, :avatar, :email)
    end
  end

  def uniq_email
    errors.add(:email, 'must be unique') if User.exists?(email: email.try(:downcase)) && (@params[:email].try(:downcase) != email.downcase)
  end
end

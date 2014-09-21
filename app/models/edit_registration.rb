class EditRegistration
  include ActiveModel::Model

  validates :company_name, presence: true, unless: -> { self.account }
  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 6}, confirmation: true, if: -> { @params[:password].present? }
  validates :password_confirmation, presence: true, if: -> { @params[:password].present? }
  validate :uniq_email

  attr_accessor(
      :user,
      :account
  )

  delegate :first_name, :last_name, :password, :password_confirmation, :email, to: :user
  delegate :company_name, to: :account

  def initialize(options = {})
    @user = User.find(options[:user_id])
    @account = user.try(:account)
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
        account.save! if account
      end

    end
  end

  private

  def assign_attributes
    @user.assign_attributes generate_params
    @account.try(:assign_attributes, @params.slice(:company_name))
  end

  def uniq_email
    errors.add(:email, 'Email must be uniq') if !(user.email.downcase == @params[:email].downcase) && User.exists?(id: @params[:user_id], email: email)
  end

  def update_user
    user.update_attributes(generate_params)
  end

  def update_account
    account.update_attributes(@params.slice(:company_name))

  end

  def generate_params
    if @params[:password].present?
      @params.slice(:first_name, :last_name, :avatar, :password, :password_confirmation, :email)
    else
      @params.slice(:first_name, :last_name, :avatar, :email)
    end
  end

end

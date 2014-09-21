class Registration
  include ActiveModel::Model

  validates :company_name, presence: true, unless: -> { self.token }
  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :tos_accepted, acceptance: true, presence: true
  validates :password, length: {minimum: 6}, confirmation: true
  validates :password_confirmation, presence: true
  validate :uniq_email

  attr_accessor :company_name,
                :email,
                :first_name,
                :last_name,
                :tos_accepted,
                :password,
                :password_confirmation,
                :persisted,
                :token,
                :user,
                :account,
                :invitation

  delegate :company_name, to: :account
  delegate :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :persisted, to: :user
  delegate :token, to: :invitation

  def register
    if valid?
      ActiveRecord::Base.transaction do
        create_user
        create_account
      end
    end
  end

  private

  def invitation_params
    {
        token: token
    }
  end

  def user_params
    {
        email: email,
        first_name: first_name,
        last_name: last_name,
        tos_accepted: tos_accepted,
        password: password
    }
  end

  def account_params
    {
        company_name: company_name,
        owner: true,
        admin: true
    }
  end

  def create_user
    @user = User.new(user_params)
    @user.save!
  end

  def create_account
    unless token.blank?
      Invitation.find_by(token: token).account.
      Account.find_by(token: token).members << @user
    else
      @user.accounts.build(account_params)
    end
  end
end

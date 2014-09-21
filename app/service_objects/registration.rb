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
                :token,
                :persisted,
                :user,
                :account

  def register
    if valid?
      ActiveRecord::Base.transaction do
        create_user
        create_account
      end
    end
  end

  private

  def uniq_email
    errors.add(:email, 'Email must be uniq') if User.exists?(email: email)
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
        company_name: company_name
    }
  end

  def create_user
    @user = User.new(user_params)
    @user.save!
  end

  def create_account
    unless token.blank?
      Account.find_by(token: token).members << @user
    else
      @account = Account.create(account_params.merge({owner: @user}))
    end
  end
end

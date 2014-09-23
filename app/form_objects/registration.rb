class Registration
  include ActiveModel::Model

  attr_accessor :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :company_name,
                :tos_accepted,
                :persisted,
                :token,
                :user

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :uniq_email
  validates :password, length: {minimum: 6}, confirmation: true
  validates :password_confirmation, presence: true
  validates :company_name, presence: true, unless: -> { self.token }
  validates :tos_accepted, acceptance: true, presence: true

  def register
    if valid?
      ActiveRecord::Base.transaction do
        create_user
        create_account
      end
    end
  end

  private

  def create_user
    @user = User.new(user_params)
    @user.save!(validate: false)
  end

  def create_account
    if token.present?
      invitation = Invitation.find_by(token: token)

      if invitation
        invitation.account.members << @user
        invitation.destroy
      end
    else
      @user.accounts.build(account_params)
    end
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

  def uniq_email
    errors.add(:email, 'must be unique') if User.exists?(email: email.downcase)
  end
end

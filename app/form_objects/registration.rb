class Registration
  include ActiveModel::Model

  attr_accessor :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :company_name,
                :tos_accepted,
                :token,
                :user,
                :account

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  validate :uniq_email
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
  validates :company_name, presence: true, unless: -> { token }
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
      @account = invitation.account

      if invitation
        @account.users << @user
        invitation.destroy
      end
    else
      @account = Account.new(account_params)
      @account.save!

      member = Member.new(member_params)
      member.save!
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
        company_name: company_name
    }
  end

  def member_params
    {
        user: @user,
        account: @account,
        owner: true,
        admin: true
    }
  end

  def uniq_email
    errors.add(:email, 'must be unique') if User.where('lower(email) = ?', email.try(:downcase)).count > 1
  end
end

class Registration
  include RegistrationValidation

  attr_accessor :company_name,
                :tos_accepted,
                :persisted,
                :token

  validates :company_name, presence: true, unless: -> { self.token }
  validates :password, length: {minimum: 6}, confirmation: true
  validates :password_confirmation, presence: true
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
    @user.save!(validate: false)
  end

  def create_account
    unless token.blank?
      invitation = Invitation.find_by(token: token)

      if invitation
        invitation.account.members << @user
        invitation.destroy
      end
    else
      @user.accounts.build(account_params)
    end
  end
end

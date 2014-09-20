class Registration
  include ActiveModel::Model

  attr_accessor(
      :company_name,
      :email,
      :first_name,
      :last_name,
      :tos_accepted,
      :password,
      :password_confirmation,
      :user,
      :account
  )

  validate :company_name, presence: true
  validate :email, presence: true, email: true, uniqueness: { case_sensitive: false, model: User, attribute: 'email' }
  validate :first_name, presence: true
  validate :last_name, presence: true
  validate :tos_accepted, acceptance: true
  validate :password, length: { minimum: 6 }, confirmation: true
  validate :password_confirmation, presence: true

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
        company_name: company_name
    }
  end

  def create_user
    @user = User.new(user_params)
    @user.save
  end

  def create_account
    @account = Account.create(account_params.merge({owner: @user}))
  end
end

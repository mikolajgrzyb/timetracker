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

  validates :company_name, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :tos_accepted, acceptance: true
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
  validate :uniq_email

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
    errors.add(:base, 'Email must be uniq') if User.exists?(email: email)

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
    @user.save
  end

  def create_account
    @account = Account.create(account_params.merge({owner: @user}))
  end
end

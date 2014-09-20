class Registration
  include ActiveModel::Model

  attr_accessor(
      :company_name,
      :email,
      :first_name,
      :last_name,
      :tos_accepted,
      :password,
      :user
  )

  validates :company_name, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :tos_accepted, acceptance: true

  def register
    if valid?
      create_user
    end
  end

  private

  def parameters
    {
        company_name: company_name,
        email: email,
        first_name: first_name,
        last_name: last_name,
        tos_accepted: tos_accepted,
        password: password
    }
  end

  def create_user
    @user = User.new(parameters)
    @user.save
  end
end

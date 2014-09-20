class Registration
  include ActiveModel::Model

  attr_accessor(
      :company_name,
      :email,
      :first_name,
      :last_name,
      :terms_of_service,
      :password
  )

  validates :company_name, presence: true
  validates :email, presence: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :terms_of_service, acceptance: true

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
        terms_of_service: terms_of_service,
        password: password
    }
  end

  def create_user
    user = User.new(parameters)
    user.save
  end
end

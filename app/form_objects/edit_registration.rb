class EditRegistration
  include RegistrationValidation

  attr_accessor :user

  validates :password, length: {minimum: 6}, confirmation: true, unless: password.blank?
  validates :password_confirmation, presence: true, unless: password.blank?

  def persisted?
    true
  end

  def update
    if valid?
      ActiveRecord::Base.transaction do
        update_user
      end
    end
  end

  def update_user
    user.update_attributes(user_params)
    user.save!(validate: false)
  end

  def user_params
    {
        first_name: first_name,
        last_name: last_name,
        email: email,
        avatar: avatar,
        password: password
    }.except(:password) unless password.present?
  end
end

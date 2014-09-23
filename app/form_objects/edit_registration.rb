class EditRegistration
  include ActiveModel::Model

  attr_accessor :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :uniq_email
  validates :password, length: { minimum: 6 }, confirmation: true, unless: -> { password.blank? }
  validates :password_confirmation, presence: true, unless: -> { password.blank? }

  def update(user)
    if valid?
      ActiveRecord::Base.transaction do
        update_attributes(user)
      end
    end
  end

  def persisted?
    true
  end

  private

  def update_attributes(user)
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

  def uniq_email
    errors.add(:email, 'must be unique') if User.exists?(email: email.downcase)
  end
end

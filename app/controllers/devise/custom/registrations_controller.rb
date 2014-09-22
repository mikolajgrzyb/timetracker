class Devise::Custom::RegistrationsController < Devise::RegistrationsController

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(new_registration_params)

    if @registration.register
      sign_up(:user, @registration.user)
    end

    respond_with @registration, location: accounts_url
  end

  def edit
    @registration = EditRegistration.new
  end

  def update
    @registration = EditRegistration.new(edit_registration_params)
    @registration.update
    respond_with @registration, location: accounts_url
  end

  private

  def new_registration_params
    params.require(:registration).permit(:company_name, :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :token)
  end

  def edit_registration_params
    params.require(:edit_registration).permit(:user_id, :company_name, :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :token, :avatar)
  end
end

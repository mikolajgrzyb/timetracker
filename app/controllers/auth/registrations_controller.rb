class Auth::RegistrationsController < Devise::RegistrationsController

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(new_registration_params)

    if @registration.register
      sign_up(:user, @registration.user)
    end

    respond_with @registration, location: account_url(@registration.account)
  end

  def edit
    @registration = EditRegistration.new(current_user)
  end

  def update
    @registration = EditRegistration.new(current_user, edit_registration_params)
    @registration.update
    respond_with @registration, location: edit_user_registration_path
  end

  private

  def new_registration_params
    params.require(:registration).permit(:company_name, :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :token)
  end

  def edit_registration_params
    params.require(:edit_registration).permit(:user_id, :company_name, :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :token, :avatar)
  end
end

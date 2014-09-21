class Devise::Custom::RegistrationsController < Devise::RegistrationsController

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(new_registration_params)

    if @registration.register
      sign_up(:user, @registration.user)
    end

    respond_with @registration, location: @registration.user.try(:first_account) ? account_url(@registration.user.first_account) : root_url
  end

  def edit
    @registration = EditRegistration.new(user_id: params[:format])

  end

  def update

    @registration = EditRegistration.new(user_id: edit_registration_params[:user_id], params: edit_registration_params)

    @registration.update

    respond_with @registration, location: account_url(@registration.user.first_account)

  end

  private

  def new_registration_params
    params.require(:registration).permit(:company_name, :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :token)
  end

  def edit_registration_params
    params.require(:edit_registration).permit(:user_id, :company_name, :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :token, :avatar)
  end
end

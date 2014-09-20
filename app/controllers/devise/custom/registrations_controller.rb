class Devise::Custom::RegistrationsController < Devise::RegistrationsController

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.register
      sign_up(:user, @registration.user)
    end

    respond_with @registration, location: accounts_url
  end

  private

  def registration_params
    params.require(:registration).permit(:company_name, :email, :first_name, :last_name, :tos_accepted, :password, :password_confirmation, :token)
  end
end

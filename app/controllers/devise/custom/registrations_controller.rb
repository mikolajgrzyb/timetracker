class Devise::Custom::RegistrationsController < Devise::RegistrationsController

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    @registration.register

    respond_with @registration, location: root_url
  end

  private

  def registration_params
    params.require(:registration).permit(:company_name, :email, :first_name, :last_name, :tos_accepted, :password)
  end
end

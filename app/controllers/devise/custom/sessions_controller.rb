class Devise::Custom::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?

    if resource.accounts.empty?
      redirect_to new_user_session_path, alert: "Sorry, but you're not a member of any account. To sign in, you have to get an invitation to an account."
    end

    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def after_sign_in_path_for(resource)
    if resource.first_account
      account_path(resource.first_account)
    else
        root_path
    end
  end

end

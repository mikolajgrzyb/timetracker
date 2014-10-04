class Devise::Custom::SessionsController < Devise::SessionsController


  def after_sign_in_path_for(resource)
    account_path(resource.first_account)
  end

end
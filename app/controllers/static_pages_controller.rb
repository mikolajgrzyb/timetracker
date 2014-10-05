class StaticPagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
  before_action :redirect_to_account

  def index

  end


  private

  def redirect_to_account
    redirect_to account_path(current_user.first_account) if current_user
  end

end

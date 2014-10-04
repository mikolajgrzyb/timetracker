class StaticPagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
  before_action :is_logged_in?

  def index

  end


  private

  def is_logged_in?
    redirect_to account_path(current_user.first_account) if current_user
  end

end

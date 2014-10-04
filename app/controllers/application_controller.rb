class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def find_account
    @account = Account.find(params[:account_id])
  end
end

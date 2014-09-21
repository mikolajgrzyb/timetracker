class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account

  def show
  end

  def invite
    InvitationMailer.invite(params[:email], current_user.account.token).deliver
    redirect_to account_url(@account)
  end

  private

  def find_account
    @account = current_user.account ? current_user.account : current_user.memberships.try(:first)
  end

end


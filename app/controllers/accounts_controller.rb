class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account

  def index
    @accounts = current_user.accounts
  end

  def invite
    InvitationMailer.invite(params[:email], account.token).deliver
    redirect_to accounts_url, notice: 'Invitation was sent.'
  end

  private

  def find_account
    @account = Account.find(params[:id])
    # @account = current_user.account ? current_user.account : current_user.memberships.try(:first)
  end
end


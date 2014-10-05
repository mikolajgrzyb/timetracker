class AccountsController < ApplicationController
  before_action :set_account, only: [:index, :edit, :update]

  def show

  end

  def index
    @accounts = current_user.accounts
  end

  def edit

  end

  def update
    if @account.update(account_params)
      redirect_to account_members_path(@account), notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end


  private

  def set_account
    @account = params[:id] ?  Account.find(params[:id]) : current_user.accounts.first
  end

  def account_params
    params.require(:account).permit(:company_name)
  end
end

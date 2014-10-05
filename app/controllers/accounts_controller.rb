class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update]

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
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:company_name)
  end
end

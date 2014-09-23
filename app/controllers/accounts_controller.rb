class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def show

  end

  def create
    @account = Account.new(account_params)

    if @account.save
      redirect_to account_url(@account), notice: 'Account was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @account.update(account_params)
      redirect_to account_url(@account), notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:company_name)
  end
end

class UsersController < ApplicationController
before_action :find_user, only: [:edit, :update]

  def edit
  
  end

  def update
    if @user.update_attributes(user_parms)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end


  def user_parms
    params.require(:user).permit(:first_name, :last_name, :avatar)
  end

end
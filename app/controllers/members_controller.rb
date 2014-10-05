class MembersController < ApplicationController
  before_action :find_account, only: [:index]
  before_action :find_member, only: [:update]
  before_action :can_update, only: [:update]
  respond_to :json, only: [:update]

  def index
    @active_members = @account.members.active
    @inactive_members = @account.members.inactive
    @invitations = @account.invitations
    @invitation = Invitation.new
  end

  def update
    if @member.update_attributes member_params
      head :no_content
    else
      render json: @member.errors.full_messages
    end
  end

  private

  def member_params
    params.require(:member).permit(:active, :role)
  end

  def can_update
    if @member.owner? || @member.admin_with_active_param?(member_params) || @member.current_and_regular?(current_user)
      return head(401)
    end
  end

  def find_member
    @member = Member.find(params[:id])
  end
end

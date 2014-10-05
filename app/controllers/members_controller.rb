class MembersController < ApplicationController
  before_action :find_account, only: [:index]

  respond_to :json, only: [:update]

  def index
    @active_members = @account.members.active
    @inactive_members = @account.members.inactive
    @invitations = @account.invitations if @account.invitations.length > 0
    @invitation = Invitation.new
  end

  def update

    @member = Member.find(params[:id])
    if @member.update_attributes active: params[:active]
      head :no_content
    else
      render json: @member.errors.full_messages
    end
  end

end

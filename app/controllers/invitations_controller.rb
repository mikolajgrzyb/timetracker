class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:update, :destroy]
  before_action :find_account, only: [:create, :new]

  def create
    @invitation = @account.invitations.build(invitation_params)
    if @invitation.save
      InvitationMailer.invite(@invitation).deliver
      redirect_to account_members_path(@account), notice: 'Invitation was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @invitation.destroy
    redirect_to account_members_path(@account), notice: 'Invitation was deleted.'
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:invitee_email).merge({ inviter: current_user })
  end
end

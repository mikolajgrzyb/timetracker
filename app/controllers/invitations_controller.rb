class InvitationsController < ApplicationController 
  before_action :find_account, only: [:create, :destroy]

  def create
    @invitation = @account.invitations.build(invitation_params)
    if @invitation.save
      InvitationMailer.invite(@invitation).deliver
      redirect_to account_members_path(@account), notice: 'Invitation was successfully created.'
    else
      redirect_to account_members_path(@account), alert: 'There was an error'
    end
  end

  def destroy
    @invitation = @account.invitations.find(params[:id])
    @invitation.destroy
    redirect_to account_members_path(@account), notice: 'Invitation was deleted.'
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitee_email).merge({ inviter: current_user })
  end
end

class InvitationsController < ApplicationController
  before_action :find_account, only: [:create, :destroy]

  def create
    @invitation = @account.invitations.build(invitation_params)
    if @invitation.save
      InvitationMailer.invite(@invitation).deliver
      redirect_to account_path(@account), notice: 'Invitation was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @invitation = @account.invitations.find(params[:id])
    @invitation.destroy
    redirect_to account_invitations_path, notice: 'Invitation was deleted.'
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitee_email).merge({ inviter: current_user })
  end
end

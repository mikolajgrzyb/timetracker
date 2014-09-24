class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:update, :destroy]

  def index
    @invitations = Invitation.all
  end

  def new
    @account = Account.find(params[:account_id])
    @invitation = @account.invitations.new
  end

  def create
    @account = Account.find(params[:account_id])
    @invitation = @account.invitations.build(invitation_params)

    if @invitation.save
      InvitationMailer.invite(@invitation).deliver
      redirect_to account_path(@account), notice: 'Invitation was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @invitation.update(invitation_params)
      redirect_to account_path(@account), notice: 'Invitation was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @invitation.destroy
    redirect_to account_invitations_path, notice: 'Invitation was deleted.'
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:invitee_email).merge({ inviter: current_user })
  end
end

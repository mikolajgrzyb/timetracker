class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  def index
    @invitations = Invitation.all
  end

  def new
    @invitation = Invitation.new
  end

  def edit
  end

  def create
    @account = Account.find(params[:account_id])
    @invitation = @account.invitations.build(invitation_params)

    if @invitation.save
      InvitationMailer.invite(params[:email], invitation.token).deliver
      redirect_to invitation_url(@invitation), notice: 'Invitation was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @invitation.update(invitation_params)
      redirect_to invitation_url(@invitation), notice: 'Invitation was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @invitation.destroy
    redirect_to invitations_path
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end

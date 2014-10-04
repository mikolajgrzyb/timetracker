class MembersController < ApplicationController
  before_action :find_account, only: [:index]

  def index
    @invitations = @account.invitations
    @invitation = Invitation.new
    @members = Member.all
  end

end

class MembersController < ApplicationController
  before_action :find_account, only: [:index]

  def index
    @active_members = Member.active
    @inactive_members = Member.inactive
  end

  def activate
  	@member = Member.find(id: params[:member_id])
  	@member.active = true
  end

  def deactivate
  	@member = Member.find(id: params[:member_id])
  	@member.active = false
  end

end

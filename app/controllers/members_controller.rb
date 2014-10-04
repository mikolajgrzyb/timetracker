class MembersController < ApplicationController
  before_action :find_account, only: [:index]

  def index
    @members = Member.all
  end

end

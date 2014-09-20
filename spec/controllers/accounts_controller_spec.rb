require 'rails_helper'

RSpec.describe AccountsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :show
      expect(response).to be_success
    end
    it 'assigns user account to @account'

  end

  describe "POST#invite" do
    it 'send invitation email'
  end

end

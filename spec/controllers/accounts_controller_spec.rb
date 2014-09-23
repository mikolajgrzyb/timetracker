require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  context "when user is not logged in" do

    it "redirects to root path" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

  context "when user is logged in" do
    let(:user) { create :user }

    before do
      sign_in :user, user
    end

    describe "GET index" do

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it "assigns user account to @account" do
        get :index
        expect(assigns(:account)).to_not be nil
      end

    end

  end

end

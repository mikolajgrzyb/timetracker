require 'rails_helper'

RSpec.describe AccountsController, :type => :controller do

  context 'when user is not logged in ' do
    it 'redirects to root path' do
      get :show
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when user is logged in' do
    let(:user) { create :user }

    before do
      sign_in :user, user
    end

    describe "GET show" do
      it "returns http success" do
        get :show
        expect(response).to be_success
      end
      it 'assigns user account to @account' do
        get :show
      end

    end

    describe "POST#invite" do
      let!(:user) { create :user }
      let!(:account) {create :account, owner: user}
      it 'send invitation email' do
        double = double({deliver: nil})
        expect(InvitationMailer).to receive(:invite).and_return(double)
        post :invite, email: 'test@test.pl'

      end
    end
  end
end

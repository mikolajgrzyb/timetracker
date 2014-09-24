require 'rails_helper'

describe InvitationsController, type: :controller do

  describe "POST#create" do

    let!(:user) { create :user }
    let!(:account) {create :account }

    before do
      sign_in :user, user
    end

    it "send invitation email" do
      double = double({deliver: nil})
      post :create, account_id: account.id, invitation: attributes_for(:invitation)
      expect(InvitationMailer).to receive(:send_invitation).and_return(double)
    end

  end

end

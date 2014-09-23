require 'rails_helper'

describe InvitationsController, type: :controller do

  describe "POST#create" do

    let!(:user) { create :user }
    let!(:account) {create :account }

    it "send invitation email" do
      double = double({deliver: nil})
      expect(InvitationMailer).to receive(:send_invitation).and_return(double)
      post :create, invitation: { email: 'test@test.pl' }, account: account
    end

  end

end

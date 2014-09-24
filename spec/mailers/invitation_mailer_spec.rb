require "rails_helper"

describe InvitationMailer, type: :mailer do

  describe "#send_invitation" do

    let(:user) {create :user}
    let(:account) {create :account, owner: user}
    let(:invitation) { create :invitation, inviter: user, account: account }

    it "sends mail" do
      expect {
        InvitationMailer.invite(invitation).deliver
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end

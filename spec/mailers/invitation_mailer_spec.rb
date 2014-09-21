require "rails_helper"

RSpec.describe InvitationMailer, :type => :mailer do
  describe '#invite' do
    let(:user) {create :user}
    let(:account) {create :account, owner: user}
    it 'assigns correct link to @link' do
      mail = InvitationMailer.invite(user.email, account.token)
      expect(mail.body.encoded).to match account.token
    end

    it 'change ' do
      expect { InvitationMailer.invite(user.email, account.token).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end

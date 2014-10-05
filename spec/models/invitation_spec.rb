require 'rails_helper'

describe Invitation, type: :model do


  let(:user) { create(:user) }
  let(:account) { create(:account) }
  let(:invitation) { create(:invitation, account: account, inviter: user) }

  it 'adds token in account creation process' do
    expect(invitation.token).not_to be_nil
  end

end

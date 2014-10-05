require 'rails_helper'

RSpec.describe MembersHelper, type: :helper do
  include Devise::TestHelpers

  describe '#can_change_state' do
    let(:user) { create :user }
    let(:account) { create :account }

    before do
      sign_in user
    end

    context 'member is current_user and is admin' do

      let!(:member) { create :member, user: user, role: 'admin' }
      it 'return false' do
        expect(helper.can_change_state(member)).to be false
      end
    end

    context 'member is current_user and is owner' do

      let!(:member) { create :member, user: user, role: 'owner' }
      it 'return false' do
        expect(helper.can_change_state(member)).to be false
      end
    end

    context 'member is member' do
      let(:user2) { create :user }
      let!(:member) { create :member, user: user, role: 'owner' }
      let!(:member2) { create :member, user: user2, role: 'regular' }
      it 'return false' do
        expect(helper.can_change_state(member2)).to be true
      end
    end
  end

end
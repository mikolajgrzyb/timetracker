require 'rails_helper'

RSpec.describe MembersController, :type => :controller do

  describe "PUT #update" do
    let(:user) { create :user }

    let(:account) { create :account }
    before do
      sign_in(user)
    end
    context 'when member has owner role' do

      let(:member) { create :member, user: user, account: account, role: 'owner' }

      it 'renders head 401' do
        put :update, account_id: account.id, id: member, member: {active: true, role: 'admin'}
        expect(response.status).to eq 401
      end

    end

    context 'when member is admin and is  current user' do
      let(:member) { create :member, user: user, account: account, role: 'admin' }
      it 'render head 401' do
        put :update, account_id: account.id, id: member, member: {active: true}
        expect(response.status).to eq 401
      end
    end
    context 'when member is regular and is current user' do
      let(:member) { create :member, user: user, account: account, role: 'regular' }
      it 'render head 401' do
        put :update, account_id: account.id, id: member, member: {active: true}
        expect(response.status).to eq 401
      end
    end

    context 'when member can update' do
      let(:user2) {create :user }

    end
  end

end

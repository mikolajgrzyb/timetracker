require 'rails_helper'

RSpec.describe MembersController, :type => :controller do

  describe "GET #index" do
    let(:user) { create :user }
    let(:user2) { create :user }

    let(:account) { create :account }
    let!(:member) { create :member, user: user, account: account, role: 'owner', active: true }
    let!(:member1) { create :member, user: user2, account: account, role: 'regular', active: false }

    before do
      sign_in(user)
    end
    it 'assigns variables' do
      get :index, account_id: account.id
      expect(assigns(:active_members)).to eq [member]
      expect(assigns(:inactive_members)).to eq [member1]
      expect(assigns(:invitation)).to be_new_record

    end
  end

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
      let(:user2) { create :user }
      let(:member2) { create :member, user: user2, account: account, role: 'regular' }
      it 'updates record' do
        put :update, account_id: account.id, id: member2, member: {active: false, role: 'admin'}
        member2.reload
        expect(member2.active).to eq false
        expect(member2.role).to eq 'admin'

      end

    end
  end

end

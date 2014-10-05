require 'rails_helper'

describe InvitationsController, type: :controller do

  let!(:user) { create :user }
  let!(:account) {create :account }
  let!(:invitation) { create :invitation, account: account }

  before do
    sign_in :user, user
  end

  describe "POST#create" do

    context "with valid params" do

      it "send invitation email" do
        double = double({deliver: nil})
        expect(InvitationMailer).to receive(:invite).and_return(double)
        post :create, account_id: account.id, invitation: attributes_for(:invitation)
      end

    end

    context "with invalid params" do

      it "renders template :new" do
        post :create, account_id: account.id, invitation: attributes_for(:invalid_invitation)
        expect(response).to render_template :new
      end

    end

  end

  describe "DELETE#destroy" do

    it "assigns invitation" do
      delete :destroy, account_id: account.id, id: invitation.id
      expect(assigns(:invitation)).to be_a Invitation
    end

    it "deletes invitation" do
      expect {
        delete :destroy, account_id: account.id, id: invitation.id
      }.to change(Invitation, :count).by -1
    end

  end

end

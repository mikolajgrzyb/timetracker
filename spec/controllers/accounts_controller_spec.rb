require 'rails_helper'

describe AccountsController, type: :controller do
  render_views

  context "when user is logged in" do
    let(:user) { create :user }

    before do
      sign_in :user, user
    end


    describe "PATCH#update" do
      let(:account) { create :account }

      it "updates account" do
        patch :update, id: account.id, account: {company_name: 'lolol'}
        account.reload
        expect(account.company_name).to eq 'lolol'
      end

      context "when with valid params" do

        it "redirects to account" do
          patch :update, id: account.id, account: attributes_for(:account)
          expect(response).to redirect_to account_members_path(account)
        end

      end

      context "when with invalid params" do

        it "renders :edit action" do
          patch :update, id: account.id, account: attributes_for(:account, company_name: nil)
          expect(response).to render_template :edit
        end

      end

    end


  end

end

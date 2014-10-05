require 'rails_helper'

describe AccountsController, type: :controller do

  context "when user is not logged in" do

    it "redirects to root path" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

  context "when user is logged in" do
    let(:user) { create :user }

    before do
      sign_in :user, user
    end

    describe "GET index" do

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it "assigns accounts" do
        get :index
        expect(assigns(:accounts)).to_not be nil
      end

    end

    describe "GET#new" do

      it "assigns account" do
        get :new
        expect(assigns(:account)).to be_a Account
      end


    end

    describe "POST#create" do

      it "creates account" do
        expect {
          post :create, account: attributes_for(:account)
        }.to change(Account, :count).by 1

      end

      it "assigns account" do
        post :create, account: attributes_for(:account)
        expect(assigns(:account)).to be_a(Account)
      end

      context "when with valid params" do
        let(:account) { create :account }

        it "redirects to account" do
          post :create, account: attributes_for(:account)
          expect(response).to redirect_to account_path(Account.last)
        end

      end

      context "when with invalid params" do
        let(:account) { create :account }

        it "renders :new template" do
          post :create, account: attributes_for(:invalid_account)
          expect(response).to render_template :new
        end

      end

    end

    describe "PATCH#update" do
      let(:account) { create :account }

      it "updates account" do
        patch :update, id: account.id, account: { company_name: 'lolol' }
        account.reload
        expect(account.company_name).to eq 'lolol'
      end

      context "when with valid params" do

        it "redirects to account" do
          patch :update, id: account.id, account: attributes_for(:account)
          expect(response).to redirect_to account_url(account)
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

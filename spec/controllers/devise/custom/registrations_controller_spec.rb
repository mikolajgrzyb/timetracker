require 'rails_helper'

describe Devise::Custom::RegistrationsController, type: :controller do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET#new" do

    it "renders new template" do
      get :new
      expect(response).to render_template :new
    end

    it "assigns new registration" do
      get :new
      expect(assigns(:registration)).to be_a Registration
    end

  end

  describe "POST#create" do

    context "when attributes are valid" do

      context "when with token param" do

        let(:user) { create(:user) }
        let!(:account) { create(:account, owner: user) }

        it "assigns registration with params" do
          post :create, registration: attributes_for(:registration, token: account.token)
          expect(assigns(:registration))

        end

        it "creates new user" do
          expect {
            post :create, registration: attributes_for(:registration, token: account.token)
          }.to change(User, :count).by 1
        end

        it "doesnt create new account" do
          expect {
            post :create, registration: attributes_for(:registration, token: account.token)
          }.to_not change(Account, :count)
        end

        it "adds user to account members" do
          expect {
            post :create, registration: attributes_for(:registration, token: account.token)
          }.to change(AccountMember, :count).by 1
        end

        it "redirects to accounts url" do
          post :create, registration: attributes_for(:registration, token: account.token)
          expect(response).to redirect_to accounts_path
        end

      end

      context "when without token param" do

        it "assigns registration with params" do
          post :create, registration: attributes_for(:registration)
          expect(assigns(:registration))
        end

        it "creates new user" do
          expect {
            post :create, registration: attributes_for(:registration)
          }.to change(User, :count).by 1
        end

        it "creates account" do
          expect {
            post :create, registration: attributes_for(:registration)
          }.to change(Account, :count).by 1
        end

        it "redirects to accounts url" do
          post :create, registration: attributes_for(:registration)
          expect(response).to redirect_to accounts_path
        end

      end

    end

    context "when attributes are invalid" do

      it "doesnt create new registration" do
        expect {
<<<<<<< HEAD
          post :create, registration: {company_name: 'lol'}
=======
          post :create, registration: attributes_for(:invalid_registration)
>>>>>>> fc04e7f3f38da4cb87d09a4fcedcc98ba04558e1
        }.to_not change(User, :count)
      end

      it "renders new form" do
        post :create, registration: attributes_for(:invalid_registration)
        expect(response).to render_template :new
      end

    end

  end

  describe "GET #edit" do
    let!(:user) { create :user }
    let!(:account) { create :account, owner: user }

    before do
      sign_in :user, user
    end
    it 'renders edit template' do
      get :edit, format: user.id
      expect(response).to render_template :edit
    end

  end

  describe "PUT #update" do
    let!(:user) { create :user }
    let!(:account) { create :account, owner: user }

    before do
      sign_in :user, user
    end
    it 'updates user' do
      put :update, edit_registration: {user_id: user.id, first_name: 'Mariusz', last_name: 'wojciech', email: 'test@test.pl'}
      expect(user.reload.first_name).to eq 'Mariusz'
    end

  end


end

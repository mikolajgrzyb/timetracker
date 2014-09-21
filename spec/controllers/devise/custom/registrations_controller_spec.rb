require 'rails_helper'

describe Devise::Custom::RegistrationsController, type: :controller do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#new" do

    it "renders new template" do
      get :new
      expect(response).to render_template :new
    end

    it "assigns new registration" do
      get :new
      expect(assigns(:registration)).to be_a Registration
    end

  end

  describe "#create" do

    context "when attributes are valid" do

      let(:registration) { create_registration }

      let(:attributes_for_request) { attributes_for(:registration) }

      context "when with token param" do

        it "assigns registration with params" do
          post :create, registration: attributes_for_request
          expect(assigns(:registration))
        end

        it "creates new user" do
          expect {
            post :create, registration: attributes_for_request
          }.to change(User, :count).by 1
        end

        it "adds user to account members" do
          expect {
            post :create, registration: attributes_for_request
          }.to change(Account, :count).by 1
        end

        it "redirects to accounts url" do
          post :create, registration: attributes_for_request
          expect(response).to redirect_to accounts_path
        end

      end

      context "when without token param" do

        it "assigns registration with params" do
          post :create
        end

        it "creates new user" do
          post :create
        end

        it "creates account" do
          post :create
        end

        it "redirects to accounts url" do
          post :create, registration: attributes_for_request
          expect(response).to redirect_to accounts_path
        end

      end

    end

    context "when attributes are invalid" do

      let(:registration) { create(:invalid_registration) }

      let(:attributes_for_request) { attributes_for(:registration) }

      it "doesnt create new registration" do
        expect {
          post :create
        }.to_not change(User, :count)
      end

      it "renders new form" do
        post :create, registration: attributes_for_request
        expect(response).to render_template :new
      end

    end

  end

end

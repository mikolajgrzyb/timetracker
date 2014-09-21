require 'rails_helper'

describe Devise::Custom::RegistrationsController, type: :controller do

  let(:registration) { create_registration }

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
      expect(assigns(:registration)).to be_a_new Registration
    end

  end

  describe "#create" do

    context "when attributes are valid" do

      context "when with token param" do

        let(:attributes_for_request) { attributes_for(:registration) }

        it "assigns registration with params" do
          post :create, registration: attributes_for_request
          expect(assigns(:registration))
        end

        it "creates new user" do
          post :create, registration: attributes_for_request
          expect(assigns(:registration)).to be_a Registration
        end

        it "adds user to account members" do
          expect {
            post :create, registration: attributes_for_request
          }.to change(Account, :count).by 1
        end

        it "redirects to accounts url" do
          post :create, registration: attributes_for_request
        end

        it "signs up user" do
          post :create
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
          post :create
        end

        it "signs up user" do
          post :create
        end

      end

    end

    context "when attributes are invalid" do

      it "doesnt create new registration" do
        expect {
          post :create
        }.to_not change(User, :count)
      end

      it "renders new form" do
        post :create, registration: attributes_for_registration
        expect(response).to render_template :new
      end

    end

  end

end

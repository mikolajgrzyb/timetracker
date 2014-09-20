require 'rails_helper'

describe Registration, type: :model do

  describe "#register" do

    context "with valid params" do
      let(:registration) { create_registration }

      it "is valid" do
        expect(registration.to be_valid)
      end

      it "creates user" do
        expect {
          registration.register
        }.to change(User, :count).by 1
      end

      it "creates account" do
        expect {
          registration.register
        }.to change(Account, :count).by 1
      end

    end

    context "with invalid params" do

      let(:registration) { create_registration }

      it "is not valid without first name" do
        registration.first_name = nil
        registration.valid?
        expect(registration.errors.messages[:first_name]).not_to be_nil
      end

      it "is not valid without last_name" do
        registration.last_name = nil
        registration.valid?
        expect(registration.errors.messages[:last_name]).not_to be_nil
      end

      it "is not valid without company_name" do
        registration.company_name = nil
        registration.valid?
        expect(registration.errors.messages[:company_name]).not_to be_nil
      end

      it "is not valid without email" do
        registration.email = nil
        registration.valid?
        expect(registration.errors.messages[:email]).not_to be_nil
      end

      it "is not valid without tos_accepted" do
        registration.tos_accepted = nil
        registration.valid?
        expect(registration.errors.messages[:tos_accepted]).not_to be_nil
      end

      it "is not valid without password" do
        registration.tos_accepted = nil
        registration.valid?
        expect(registration.errors.messages[:password]).not_to be_nil
      end

      it "is not valid if password is not confirmed" do
        registration.password_confirmation = 'password123'
        registration.valid?
        expect(registration.errors.messages[:password_confirmation]).not_to be_nil
      end

      it "is not valid if email is not unique" do
        registration1 = create_registration
        registration1.register

        registration2 = create_static_registration
        registration2.email = registration1.email
        registration2.register

        expect(registration.errors.messages[:email]).not_to be_nil

      end


      it "doesn't create user" do
        expect {
          registration.register
        }.to change(User, :count)
      end

      it "doesn't create account" do
        expect {
          registration.register
        }.not_to change(Account, :count)

      end

    end

  end

end

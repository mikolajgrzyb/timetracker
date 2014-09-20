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

      # let(:registration) { create_registration }

      it "is not valid without first name" do
        registration = Registration.new({})
        registration.valid?
        # expect(registration.errors.messages[:first_name]).not_to be_nil
        expect(registration).not_to be_valid
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

require 'rails_helper'

describe EditRegistration, type: :model do

  describe "#update" do

    let(:user) { create :user }
    let(:registration) { EditRegistration.new user: user, params: edit_registration_params }

    it "is persisted" do
      expect(registration.persisted?).to eq true
    end

    context "with valid params" do

      it "is valid" do
        expect(registration).to be_valid
      end

      it "updates user first_name" do
        expect {
          registration.update
        }.to change(user, :first_name)
      end

    end

    context "with invalid params" do

      it "is not valid without first name" do
        registration.user.first_name = nil
        registration.valid?
        expect(registration.errors.messages[:first_name].size).to eq 1
      end

      it "is not valid without last_name" do
        registration.user.last_name = nil
        registration.valid?
        expect(registration.errors.messages[:last_name].size).to eq 1
      end

      it "is not valid without email" do
        registration.user.email = ""
        registration.valid?
        expect(registration.errors.messages[:email].size).to eq 2
      end

      let(:user2) { create :user }
      let(:params) { user.attributes.merge(email: user2.email) }

      it "is not valid if email is not unique" do
        registration = EditRegistration.new(user: user, params: params)
        registration.update

        expect(registration.errors.messages[:email]).not_to be_nil
      end

    end

  end

end

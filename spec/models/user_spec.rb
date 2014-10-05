require 'rails_helper'

describe User, type: :model do

  let(:user) { create(:user) }

  describe "#first_account" do

    it "returns first account for user" do
      expect(user.first_account).to eq user.accounts.first
    end

  end

end

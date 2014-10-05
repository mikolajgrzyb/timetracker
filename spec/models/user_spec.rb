require 'rails_helper'

describe User, type: :model do

  let(:user) { create(:user) }
  let(:account) { create(:account) }

  describe "#first_account" do

    it "returns first account for user" do
      user.accounts << account
      expect(user.first_account).to eq account
    end

  end

end

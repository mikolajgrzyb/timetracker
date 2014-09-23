require 'rails_helper'

describe Account, type: :model do

  it 'adds token in account creation process' do
    user = FactoryGirl.create :user
    account = FactoryGirl.create :account, owner: user
    expect(account.token).not_to be_nil
  end

end

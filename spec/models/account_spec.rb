require 'rails_helper'

RSpec.describe Account, :type => :model do

  it 'adds token in account creation process' do
    user = FactoryGirl.create :user
    account = FactoryGirl.create :account, owner: user
    expect(account.token).not_to be_nil
  end

  it 'validates owner_id' do
    account = FactoryGirl.build(:account)
    account.valid?
    expect(account.errors.messages[:owner_id]).not_to eq nil
  end

end

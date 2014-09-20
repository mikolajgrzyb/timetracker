require 'rails_helper'

RSpec.describe Account, :type => :model do

  it 'validates uniqueness of company_name'
  it 'adds token in account creation process'
  it 'validates owner_id'
end

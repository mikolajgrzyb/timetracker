require 'faker'

FactoryGirl.define do

  factory :account do
    sequence :company_name do
      Faker::Company.name
    end
  end

end

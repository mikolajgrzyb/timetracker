require 'faker'

FactoryGirl.define do

  factory :account do
    company_name { Faker::Company.name }

    factory :invalid_account do
      company_name ''
    end
  end

end

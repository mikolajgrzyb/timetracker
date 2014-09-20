require 'faker'

FactoryGirl.define do

  factory :accounts do
    sequence :company_name do
      Faker::Company.name
    end
  end

end

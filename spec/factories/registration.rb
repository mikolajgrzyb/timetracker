require 'faker'

FactoryGirl.define do

  factory :registration do
    company_name { Faker::Company.name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end

end

require 'faker'

FactoryGirl.define do

  factory :registration do
    company_name { Faker::Company.name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    tos_accepted '1'

    factory :invalid_registration do
      tos_accepted '0'
    end
  end

end

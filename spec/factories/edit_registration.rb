require 'faker'

FactoryGirl.define do

  factory :edit_registration do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password {}
  end

end

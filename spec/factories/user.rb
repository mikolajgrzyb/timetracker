require 'faker'

FactoryGirl.define do

  factory :user do

    sequence :first_name do
      Faker::Name.first_name
    end

    sequence :last_name do
      Faker::Name.last_name
    end

    sequence :email do
      Faker::Internet.email
    end

    password 'test1234'
    password_confirmation 'test1234'
  end
end
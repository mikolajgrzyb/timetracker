require 'faker'

FactoryGirl.define do

  factory :user do

    sequence first_name do

    end

    sequence :email do
      Faker::Internet.email
    end

    password 'test1234'
    password_confirmation 'test1234'
  end
end
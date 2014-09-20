require 'faker'

FactoryGirl.define do

  factory :user do

    sequence :email do
      Faker::Internet.email
    end

    password 'test1234'
    password_confirmation 'test1234'
  end
end
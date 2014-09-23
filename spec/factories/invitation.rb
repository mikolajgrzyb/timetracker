require 'faker'

FactoryGirl.define do

  factory :invitation do
    invitee_email { Faker::Internet.email }
  end

end

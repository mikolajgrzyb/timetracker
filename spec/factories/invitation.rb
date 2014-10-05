require 'faker'

FactoryGirl.define do

  factory :invitation do
    invitee_email { Faker::Internet.email }

    factory :invalid_invitation do
      invitee_email nil
    end
  end

end

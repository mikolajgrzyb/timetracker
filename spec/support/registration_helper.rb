require 'rails_helper'

def create_registration
      Registration.new(
        company_name: Faker::Company.name,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password')
end


def create_static_registration
  Registration.new(
      company_name: 'asd',
      first_name: 'asd',
      last_name: 'asd',
      email: 'asd@asd.com',
      password: 'password',
      password_confirmation: 'password')
end

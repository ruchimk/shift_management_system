# Establishes a factory for generating random user information for testing use.

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    password "password"
    password_confirmation "password"
  end

end

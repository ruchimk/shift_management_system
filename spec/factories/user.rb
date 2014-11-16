# Establishes a factory for generating random user information for testing use.

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password "password"
    password_confirmation "password"
  end
end

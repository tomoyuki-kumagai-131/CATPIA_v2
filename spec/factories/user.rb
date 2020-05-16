FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@examle.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
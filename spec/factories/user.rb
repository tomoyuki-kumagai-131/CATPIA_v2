FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@examle.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    introduction { "よろしくお願いします" }
    # テスト用にadmin属性を追加する
    trait :admin do
      admin { true }
    end
  end
end

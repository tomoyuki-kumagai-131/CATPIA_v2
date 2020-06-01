FactoryBot.define do
  factory :shop do
    name { "ひとやすみ。" }
    address { "名古屋市中区栄１−９−３" }
    web_page { "https://ameblo.jp/nekocafe-hitoyasumi/" }
    description { "閑静な住宅街にある猫カフェ。ついつい通ってしまいます。" }
    recommended_points { "世界の珍しい猫が集まっています！" }
    rating { 5 }
    association :user
    created_at { Time.current }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test-shop.jpg')) }
  end
end

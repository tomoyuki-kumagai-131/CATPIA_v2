FactoryBot.define do
  factory :shop do
    name { "ひとやすみ。" }
    address { "名古屋市中区栄１−９−３" }
    web_page { "https://ameblo.jp/nekocafe-hitoyasumi/" }
    description { "閑静な住宅街にある猫カフェ。ついつい通ってしまいます。" }
    recommended_points { "世界の珍しい猫が集まっています！" }
    rating { 5 }
    association :user
  end
end

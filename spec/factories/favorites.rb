FactoryBot.define do
  factory :favorite do
    association :shop
    association :user # shop,user にbelongs_toしている
  end
end

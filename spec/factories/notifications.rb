FactoryBot.define do
  factory :notification do
    shop_id { 1 }
    variety 1
    content ""
    from_user_id { 1 }
    association :user
  end
end

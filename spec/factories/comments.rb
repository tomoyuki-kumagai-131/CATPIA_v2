FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "かわいい白猫もいますよね！" }
    association :shop
  end
end

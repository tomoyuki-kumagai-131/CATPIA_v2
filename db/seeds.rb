User.create!(name: "山田 太郎",
            email: "sample@example.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email:  email,
               password: password,
               password_confirmation: password)
end

10.times do |n|
  Shop.create!(name: Faker::Company.name,
               address: "名古屋市中区栄１−９−３",
               web_page: "https://ameblo.jp/nekocafe-hitoyasumi/",
               description: "閑静な住宅街にある猫カフェ。ついつい通ってしまいます。",
               recommended_points: "世界の珍しい猫が集まっています！",
               rating: 5,
               user_id: 1)
end

# リレーションシップについてサンプルデータを作成
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
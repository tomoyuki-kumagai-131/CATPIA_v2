User.create!(
  [
    {
      name: "管理 太郎",
      email: "kanri1@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name: "山田 杏果",
      email: "yamada1@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
    },
    {
      name: "採用 者様",
      email: "recruit1@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
    },
  ]
)

# フォロー関係
user1 = User.find(1)
user2= User.find(2)
user3 = User.find(3)
user3.follow(user1)
user3.follow(user2)

# ねこカフェ
name1 = "猫カフェ Mocha 名古屋栄店"
name2 = "保護猫カフェ ひとやすみ"
name3 = "てまりのおうち"
name4 = "ねこぶくろ"
name5 = "猫カフェ きゃりこ 新宿店"
name6 = "いやし亭 ほご猫茶屋"
name7 = "猫cafeぐるぐる堂"
name8 = "SAVE CAT CAFE"
name9 = "猫カフェラグドール なんば店"

description1 = "名古屋の栄にあるねこカフェ。矢場町駅から近く、お洒落な空間でゆったりとくつろげます。"
description2 = "名古屋の繁華街、錦3丁目にあるねこカフェです。保護ねこちゃんがいて、譲渡も行っています。"
description3 = "東京の吉祥寺にあるねこカフェ。看板猫のてまりちゃんがお出迎えします。"
description4 = "東京の池袋にあるねこカフェ。東急ハンズ8階にあります。"
description5 = "東京の新宿にあるねこカフェ。都内最大級の猫カフェですよ！"
description6 = "ほご猫茶屋「いやし亭」は新橋唯一の譲渡型ほご猫カフェです。"
description7 = "難波駅から徒歩3分程の場所にある「猫cafeぐるぐる堂」は、南国リゾート風のお洒落な猫カフェです。"
description8 = "保護された猫たちが集まっています。保護猫とのふれあいを通じて、保護猫について知る機会にもなりますよ。"
description9 = " 満席でも客数より確実に猫の数の方が多いのもこだわりのカフェ。ラグドールなどかわいい猫ちゃんが沢山いますよ♪"

recommended_points1 = "長毛種の猫ちゃんがが沢山います！"
recommended_points2 = "働いているねこちゃん達は保護ねこで譲渡も行っていますよ。"
recommended_points3 = "不思議な猫の森がコンセプトで、おとぎ話に紛れ込んだかのようです！"
recommended_points4 = "東急ハンズにあるのでアクセスしやすいですよ。"
recommended_points5 = "様々な種類の猫がいますよ！"
recommended_points6 = "和風な雰囲気で座卓とテーブル席があります！"
recommended_points7 = "ドリンクも本格的なアジアンメニューが用意されてますよ！"
recommended_points8 = "ランチやカフェ使いにもぴったりです。"
recommended_points9 = "ラグドール好きにはたまらないねこカフェですよ！"

# 上記３ユーザーにねこカフェを3投稿ずつ作成する #
Shop.create!(
  [
    {
      name: name1,
      address: "愛知県名古屋市中区栄3-32-6 BECOME SAKAE 2F",
      picture: open("#{Rails.root}/public/images/ccafe7.jpg"),
      web_page: "http://catmocha.jp/nagoya/",
      description: description1,
      recommended_points: recommended_points1,
      rating: 3,
      user_id: 1
    },
    {
      name: name2,
      address: "名古屋市中区錦3-1-6 ソアービル錦2F",
      picture: open("#{Rails.root}/public/images/ccafe2.jpg"),
      web_page: "http://www.nekocafe-hitoyasumi.com/",
      description: description2,
      recommended_points: recommended_points2,
      rating: 4,
      user_id: 2
    },
    {
      name: name3,
      address: "東京都武蔵野市吉祥寺本町２丁目１３−１４",
      picture: open("#{Rails.root}/public/images/ccafe3.jpg"),
      web_page: "http://www.temarinoouchi.com/",
      description: description3,
      recommended_points: recommended_points3,
      rating: 5,
      user_id: 3
    },
    {
      name: name4,
      address: "東京都豊島区東池袋1ー28ー10 東急ハンズ池袋店8F",
      picture: open("#{Rails.root}/public/images/ccafe4.jpg"),
      web_page: "https://nekobukuro.com/",
      description: description4,
      recommended_points: recommended_points4,
      rating: 4,
      user_id: 1
    },
    {
      name: name5,
      address: "東京都新宿区歌舞伎町1-16-2 富士ビル 5F・6F",
      picture: open("#{Rails.root}/public/images/ccafe5.jpg"),
      web_page: "http://catcafe.jp/",
      description: description5,
      recommended_points: recommended_points5,
      rating: 5,
      user_id: 2
    },
    {
      name: name6,
      address: "東京都港区新橋3丁目5−11",
      picture: open("#{Rails.root}/public/images/ccafe6.jpg"),
      web_page: "https://iyashitei-hogonekochaya.com/",
      description: description6,
      recommended_points: recommended_points6,
      rating: 4,
      user_id: 3
    },
    {
      name: name7,
      address: "大阪府大阪市中央区西心斎橋2-4-6 花月第一ビル4F階",
      picture: open("#{Rails.root}/public/images/ccafe1.jpg"),
      web_page: "http://www.nekocafegurugurudou.com/",
      description: description7,
      recommended_points: recommended_points7,
      rating: 4,
      user_id: 1
    },
    {
      name: name8,
      address: "大阪府大阪市北区天神橋5-7-8 山田ビル201",
      picture: open("#{Rails.root}/public/images/ccafe8.jpg"),
      web_page: "http://www.savecatcafe.net/",
      description: description8,
      recommended_points: recommended_points8,
      rating: 5,
      user_id: 2
    },
    {
      name: name9,
      address: "大阪府大阪市中央区難波千日前13-6 大一ビル5階",
      picture: open("#{Rails.root}/public/images/ccafe3.jpg"),
      web_page: "http://matatabicoffee.catfood.jp/",
      description: description9,
      recommended_points: recommended_points9,
      rating: 4,
      user_id: 3
    }
  ]
)

shop1 = Shop.find(1)
shop3 = Shop.find(3)
shop4 = Shop.find(4)
shop6 = Shop.find(6)
shop8 = Shop.find(8)
shop9 = Shop.find(9)

# お気に入り登録
user3.favorite(shop1)
user3.favorite(shop4)
user1.favorite(shop9)
user2.favorite(shop6)

# コメント投稿
shop3.comments.create(user_id: user1.id, content: "今度名古屋に行った時に訪ねてみます♫")
shop8.comments.create(user_id: user2.id, content: "保護猫を探していますので行ってみます！")

# 通知機能 variety1=お気にいり variety2=コメント
user3.notifications.create(user_id: user3.id, shop_id: shop9.id,
  from_user_id: user1.id, variety: 1)

user3.notifications.create(user_id: user3.id, shop_id: shop3.id,
  from_user_id: user1.id, variety: 2, content: "今度名古屋に行った時に訪ねてみます♫")

user3.notifications.create(user_id: user3.id, shop_id: shop6.id,
  from_user_id: user2.id, variety: 1)

user3.notifications.create(user_id: user3.id, shop_id: shop8.id,
  from_user_id: user2.id, variety: 2, content: "保護猫を探していますので行ってみます！")

class Favorite < ApplicationRecord
  # Use,Shopモデルへのリレーション
  belongs_to :user
  belongs_to :shop
  # 降順(新しい順)にお気に入り投稿を並べる
  default_scope -> { order(created_at: :desc) }
  # バリデーション user_id,shop_id は必須である
  validates :user_id, presence: true
  validates :shop_id, presence: true
end

class Favorite < ApplicationRecord
  # Use,Shopモデルへのリレーション
  belongs_to :user
  belongs_to :shop
  # バリデーション user_id,shop_id は必須である
  validates :user_id, presence: true
  validates :shop_id, presence: true
end

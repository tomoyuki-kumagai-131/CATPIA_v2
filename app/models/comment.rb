class Comment < ApplicationRecord
  belongs_to :shop # ねこカフェ投稿に属する
  validates :user_id, presence: true
  validates :shop_id, presence: true
  validates :content, presence: true, length: { maximum: 50 } # コメントの長さは50文字が限度
end

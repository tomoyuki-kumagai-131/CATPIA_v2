class Shop < ApplicationRecord #コールバック call back・・・例として登録後の確認メール
  belongs_to :user
  has_many :favorites, dependent: :destroy # お気に入り機能実装により追記
  has_many :comments, dependent: :destroy # コメント機能実装による追記
  has_many :favorited_users, through: :favorites, source: :user # いいねランキング実装により追記
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 150 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :recommended_points, length: { maximum: 50 }
  validates :rating,
            :numericality => {
              :only_interger => true,
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 5
            },
            allow_nil: true
  validate :picture_size
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  acts_as_taggable

  # ねこカフェ投稿に附するコメントのフィードを作成 #
  def feed_comment(shop_id)
    Comment.where("shop_id = ?", shop_id)
  end

  private

    # アップロード画像の容量を制限する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, ":5MBより大きい画像はアップロードできません。")
      end
    end
end

class User < ApplicationRecord
  # ユーザーモデル
  has_many :shops, dependent: :destroy
  # フォロー機能
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed # 能動的なフォロー
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :favorites, dependent: :destroy # お気に入り機能実装により追記
  has_many :favorited_shops, through: :favorites, source: :shop # いいねランキング実装により追記
  has_many :notifications, dependent: :destroy # 通知機能実装により追記

  has_many :messages, dependent: :destroy # DM機能実装により追記
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

  attr_accessor :remember_token # 仮想の属性
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :introduction, presence: false, length: { maximum: 50 } # 自己紹介の最高文字数は50文字

  class << self
    # 渡された文字列のハッシュ値を返すメソッド
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムにトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # フィード一覧を取得(自分の投稿・フォロー中のユーザーの投稿を表示するようにする)
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Shop.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # 永続セッションのため、ユーザーをデータベースに保存するメソッド
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返すメソッド
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄するメソッド
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 他者をフォローする
  def follow(other_user)
    following << other_user
  end

  # 他者をアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしていたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 現在のユーザーがフォローされていたらtrueを返す
  def followed_by?(other_user)
    followers.include?(other_user)
  end

  ## お気に入り登録機能 ##
  # ねこカフェをお気に入りに登録する
  def favorite(shop)
    Favorite.create!(user_id: id, shop_id: shop.id)
  end

  # ねこカフェをお気に入り解除する
  def unfavorite(shop)
    Favorite.find_by(user_id: id, shop_id: shop.id).destroy
  end

  # 現在のユーザーがお気に入り登録してたらtrueを返す
  def favorite?(shop)
    !Favorite.find_by(user_id: id, shop_id: shop.id).nil?
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end

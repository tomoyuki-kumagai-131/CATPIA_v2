require 'rails_helper'

RSpec.describe Shop, type: :model do
  let!(:shop) { create(:shop) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(shop).to be_valid
    end

    it "店名がなければ無効な状態であること" do
      shop = build(:shop, name: nil)
      shop.valid?
      expect(shop.errors[:name]).to include("を入力してください")
    end

    it "店名が30文字以内であること" do
      shop = build(:shop, name: "あ" * 31)
      shop.valid?
      expect(shop.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が150文字以内であること" do
      shop = build(:shop, description: "あ" * 151)
      shop.valid?
      expect(shop.errors[:description]).to include("は150文字以内で入力してください")
    end

    it "おすすめポイントが50文字以内であること" do
      shop = build(:shop, recommended_points: "あ" * 51)
      shop.valid?
      expect(shop.errors[:recommended_points]).to include("は50文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      shop = build(:shop, user_id: nil)
      shop.valid?
      expect(shop.errors[:user_id]).to include("を入力してください")
    end

    it "おすすめ度が1以上でなければ無効な状態であること" do
      shop = build(:shop, rating: 0)
      shop.valid?
      expect(shop.errors[:rating]).to include("は1以上の値にしてください")
    end

    it "おすすめ度が5以下でなければ無効な状態であること" do
      shop = build(:shop, rating: 6)
      shop.valid?
      expect(shop.errors[:rating]).to include("は5以下の値にしてください")
    end
  end

  context "並び順" do
    it "最も新しい投稿が最初の投稿になっていること" do
      expect(shop).to eq Shop.first
    end
  end
end

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(comment).to be_valid
    end

    it "user_idがなければ無効な状態であること" do
      comment = build(:comment, user_id: nil)
      expect(comment).not_to be_valid
    end

    it "shop_idがなければ無効な状態であること" do
      comment = build(:comment, shop_id: nil)
      expect(comment).not_to be_valid
    end

    it "内容がなければ無効な状態であること" do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
    end

    it "内容が50文字以内であること" do
      comment = build(:comment, content: "あ" * 51)
      comment.valid?
      expect(comment.errors[:content]).to include("は50文字以内で入力してください")
    end
  end
end

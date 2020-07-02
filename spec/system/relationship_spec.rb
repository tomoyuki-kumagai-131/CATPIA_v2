require 'rails_helper'

# システムテスト フォロー中にフォロワーページへアクセスした時、期待する文字列やタイトルやユーザーなどが表示れているか確認するため

RSpec.describe "Relationships", type: :system do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:user4) { create(:user) }
  let!(:shop) { create(:shop, user: user) } # 自分が投稿したねこカフェ
  let!(:shop2) { create(:shop, user: user2) } # フォロー中ユーザーが投稿したねこカフェ
  let!(:shop3) { create(:shop, user: user3) } # フォローしていないユーザーが投稿したねこカフェ

  describe "フォロー中(following一覧)ページ" do
    before do
      create(:relationship, follower_id: user.id, followed_id: user2.id)
      create(:relationship, follower_id: user.id, followed_id: user3.id)
      login_for_system(user)
      visit following_user_path(user)
    end

    context "ページレイアウト" do
      it "「フォロー中」の文字列が存在すること" do
        expect(page).to have_content 'フォロー中'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('フォロー中')
      end
    end
  end

  describe "フォロワー(followers一覧)ページ" do
    before do
      create(:relationship, follower_id: user2.id, followed_id: user.id)
      create(:relationship, follower_id: user3.id, followed_id: user.id)
      create(:relationship, follower_id: user4.id, followed_id: user.id)
      login_for_system(user)
      visit followers_user_path(user)
    end

    context "ページレイアウト" do
      it "「フォロワー」の文字列が存在すること" do
        expect(page).to have_content 'フォロワー'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('フォロワー')
      end
    end
  end

  describe "フィード" do
    before do
      create(:relationship, follower_id: user.id, followed_id: user2.id)
      login_for_system(user)
    end

    it "フィードに自分の投稿が含まれていること" do
      expect(user.feed).to include shop
    end

    it "フィードにフォロー中ユーザーの投稿が含まれていること" do
      expect(user.feed).to include shop2
    end

    it "フィードにフォローしていないユーザーの投稿が含まれていないこと" do
      expect(user.feed).not_to include shop3
    end
  end
end

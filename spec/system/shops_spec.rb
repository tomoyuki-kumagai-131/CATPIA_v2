require 'rails_helper'

RSpec.describe "Shops", type: :system do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }

  describe "ねこカフェ登録ページ" do
    before do
      login_for_system(user)
      visit new_shop_path
    end

    context "ページレイアウト" do
      it "「ねこカフェ投稿」の文字列が存在すること" do
        expect(page).to have_content 'ねこカフェ投稿'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('ねこカフェ投稿')
      end

      it "入力部分に適切なフォームラベルが表示されること" do
        expect(page).to have_content '店名'
        expect(page).to have_content '説明'
        expect(page).to have_content '住所'
        expect(page).to have_content 'おすすめポイント'
        expect(page).to have_content 'WEBページ'
        expect(page).to have_content 'おすすめ度 [1~5]'
      end
    end

    context "ねこカフェ登録処理" do
      it "有効な情報でねこカフェ登録を行うとねこカフェ登録成功のフラッシュが表示されること" do
        fill_in "店名", with: "ひとやすみ"
        fill_in "説明", with: "世界中の珍しいねこが集まるカフェです。"
        fill_in "住所", with: "名古屋市中区栄１−１−１"
        fill_in "おすすめポイント", with: "お洒落なカフェが併設されています。"
        fill_in "WEBページ", with: "http://google.com"
        fill_in "shop[rating]", with: 5
        click_button "登録する"
        expect(page).to have_content "ねこカフェの投稿が完了しました！"
      end

      it "無効な情報でねこカフェ登録を行うとねこカフェ登録失敗のフラッシュが表示されること" do
        fill_in "店名", with: ""
        fill_in "説明", with: "世界中の珍しいねこが集まるカフェです。"
        fill_in "住所", with: "名古屋市中区栄１−１−１"
        fill_in "おすすめポイント", with: "お洒落なカフェが併設されています。"
        fill_in "WEBページ", with: "http://google.com"
        fill_in "shop[rating]", with: 5
        click_button "登録する"
        expect(page).to have_content "店名を入力してください"
      end
    end
  end

  describe "ねこカフェ詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit shop_path(shop)
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title("#{shop.name}")
      end

      it "ねこカフェの情報が表示されることを確認" do
        expect(page).to have_content shop.name
        expect(page).to have_content shop.description
        expect(page).to have_content shop.address
        expect(page).to have_content shop.recommended_points
        expect(page).to have_content shop.web_page
        expect(page).to have_content shop.rating
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Shops", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:shop) { create(:shop, :picture, user: user) }
  let!(:comment) { create(:comment, user_id: user.id, shop: shop) } # コメント機能作成により追記

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
        attach_file "shop[picture]", "#{Rails.root}/spec/fixtures/test-shop.jpg"
        click_button "登録する"
        expect(page).to have_content "ねこカフェの投稿が完了しました！"
      end

      #it "画像なしでねこカフェ登録を行うと、デフォルトの画像が割り当てられること" do
        #fill_in "店名", with: "ひとやすみ"
        #fill_in "住所", with: "名古屋市中区栄１−１ー１"
        #click_button "登録する"
        #expect(page).to have_link(href: shop_path(Shop.first)) 
     # end

      #it "無効な情報でねこカフェ登録を行うとねこカフェ登録失敗のフラッシュが表示されること" do
        #fill_in "店名", with: ""
        #fill_in "説明", with: "世界中の珍しいねこが集まるカフェです。"
        #fill_in "住所", with: "名古屋市中区栄１−１−１"
        #fill_in "おすすめポイント", with: "お洒落なカフェが併設されています。"
        #fill_in "WEBページ", with: "http://google.com"
        #fill_in "shop[rating]", with: 5
        #click_button "登録する"
        #expect(page).to have_content "店名を入力してください"
      #end
    end
  end
#----------------------------------------------------------------------------#
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
        expect(page).to have_content "★"
        expect(page).to have_link nil, href: shop_path(shop), class: 'shop-picture' # 投稿詳細ページで画像表示されているか
      end
    end

    context "ねこカフェ投稿の削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit shop_path(shop)
        within find('.change-shop') do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '投稿が削除されました！'
      end
    end
  end
#----------------------------------------------------------------------------#
  describe "ねこカフェ投稿編集ページ" do
    before do
      login_for_system(user)
      visit shop_path(shop)
      click_link "編集"
    end

    it "入力部分に適切なラベルが表示されること" do
      expect(page).to have_content '店名'
      expect(page).to have_content '説明'
      expect(page).to have_content '住所'
      expect(page).to have_content 'おすすめポイント'
      expect(page).to have_content 'WEBページ'
      expect(page).to have_content 'おすすめ度 [1~5]'
    end

    context "ねこカフェの更新処理" do
      it "有効な更新" do
        fill_in "店名", with: "ひとやすみ。"
        fill_in "住所", with: "名古屋市中区栄１ー１"
        attach_file "shop[picture]", "#{Rails.root}/spec/fixtures/test-shop2.jpg" # 画像添付して更新する
        click_button "更新する"
        expect(shop.reload.picture.url).to include "test-shop2.jpg"
      end

      #it "無効な更新" do
        #fill_in "店名", with: ""
        #click_button "更新する"
        #expect(page).to have_content '店名を入力してください'
        #expect(shop.reload.name).not_to eq ""
      #end
    end

    context "投稿の削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept #js
        expect(page).to have_content '投稿が削除されました！'
      end
    end
#----------------------------------------------------------------------------#
    context "コメントの登録処理・削除" do
      it "自分のねこカフェ投稿に対するコメントの登録・削除が正常に行えること" do
        login_for_system(user)
        visit shop_path(shop)
        fill_in "comment_content", with: "かわいいネコがいますよね"
        click_button "コメント"
        within find("#comment-#{Comment.last.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', 'かわいいネコがいますよね'
        end
        expect(page).to have_content "コメントを投稿しました！"
        click_link "削除", href: comment_path(Comment.last)
        expect(page).not_to have_selector 'span', text: 'かわいいネコがいますよね' 
        expect(page).to have_content "コメントを削除しました！"
      end

      it "別ユーザーのねこカフェのコメントには削除リンクがないこと" do
        login_for_system(other_user)
        visit shop_path(shop)
        within find("#comment-#{comment.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: comment.content
          expect(page).not_to have_link '削除', href: shop_path(shop)
        end
      end
    end
  end
end

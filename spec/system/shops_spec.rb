require 'rails_helper'

RSpec.describe "Shops", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:shop) { create(:shop, :picture, user: user) }
  let!(:comment) { create(:comment, user_id: user.id, shop: shop) }

  describe "ねこカフェ登録ページ" do
    before do
      login_for_system(user)
      visit new_shop_path
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('猫カフェ投稿')
      end
    end

    context "ねこカフェ登録処理" do
      it "有効な情報でねこカフェ登録を行うとねこカフェ詳細ページに飛ぶこと" do
        fill_in "店名", with: "ひとやすみ。"
        fill_in "説明", with: "世界中の珍しいねこが集まるカフェです。"
        fill_in "所在地", with: "名古屋市中区栄１−１−１"
        fill_in "おすすめポイント", with: "お洒落なカフェが併設されています。"
        fill_in "WEBページ", with: "http://google.com"
        fill_in "shop[rating]", with: 5
        attach_file "shop[picture]", "#{Rails.root}/spec/fixtures/test-shop.jpg"
        click_button "登録する"
        expect(page).to have_title full_title("#{shop.name}")
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

      it "編集と削除が表示されていることを確認" do
        expect(page).to have_link '削除', href: shop_path(shop)
        expect(page).to have_link '編集', href: edit_shop_path(shop)
      end
    end
  end

  describe "ねこカフェ投稿編集ページ" do
    before do
      login_for_system(user)
      visit shop_path(shop)
      click_link "編集"
    end

    context "ねこカフェの更新処理" do
      it "有効な更新" do
        fill_in "店名", with: "ひとやすみ。"
        fill_in "所在地", with: "名古屋市中区栄１ー１"
        attach_file "shop[picture]", "#{Rails.root}/spec/fixtures/test-shop2.jpg" # 画像添付して更新する
        click_button "更新する"
        expect(shop.reload.picture.url).to include "test-shop2.jpg"
      end
    end

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
        # expect(page).to have_content "コメントを投稿しました！"
        click_link "削除", href: comment_path(Comment.last)
        expect(page).not_to have_selector 'span', text: 'かわいいネコがいますよね'
        # expect(page).to have_content "コメントを削除しました！"
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

  describe "検索機能" do
    context "ログイン中の場合" do
      before do
        login_for_system(user)
        visit root_path
      end

      it "ログイン後に検索フォームが表示されていることを確認" do
        expect(page).to have_css 'form#shop_search'
      end
    end
  end

  describe "ランキング機能" do
    context "ログイン中の場合" do
      before do
        login_for_system(user)
        visit rank_path
      end

      it "正常にランキング表示されていることを確認" do
        expect(page).to have_css 'h5.col-md-4.mx-auto'
      end

      it "投稿者名が表示されていることを確認" do
        expect(page).to have_css '.user-name.rank'
      end
    end
  end

  describe "ランダム表示機能" do
    context "ログイン中の場合" do
      before do
        login_for_system(user)
        visit random_path
      end

      it "正常にタイトル表示されていることを確認" do
        expect( find('h4.rank-cat', visible: false).text(:all) ).to include '今日の猫カフェ'
      end

      it "正常にランダム表示されていることを確認" do
        expect( find('h5.col-md-4.mx-auto', visible: false).text(:all) ).to include '第1位'
      end
    end
  end

  describe "マップ機能" do
    context "ログイン中の場合" do
      before do
        login_for_system(user)
        visit mapindex_path
      end

      it "正常にマップ表示されていることを確認" do
        expect find('#map.gmap-mapindex', visible: false)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }
  let!(:other_shop) { create(:shop, user: other_user) }
  describe "ユーザー一覧ページ" do
    context "管理者ユーザーの場合" do
      it "ページネーション、自分以外のユーザーに削除ボタンが表示されることを確認" do
        create_list(:user, 31)
        login_for_system(admin_user)
        visit users_path
        expect(page).to have_css "div.pagination"
        expect(page).to have_link '削除', href: user_path(user) unless admin_user
      end
    end

    context "管理者ユーザー以外の場合" do
      it "ぺージネーション、自分のアカウントのみ削除ボタンが表示されること" do
        create_list(:user, 31)
        login_for_system(user)
        visit users_path
        expect(page).to have_css "div.pagination"
        expect(page).to have_link '削除', href: user_path(user) unless admin_user
      end
    end
  end

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "ユーザー名", with: "Example User"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "password"
        click_button "登録する"
        expect(page).to have_content "CATPIAへようこそ!"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "pass"
        click_button "登録する"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
      end
    end
  end

  describe "プロフィール編集ページ" do
    before do
      login_for_system(user) # test_helper定義
      visit user_path(user)
      click_link "プロフィール編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール編集')
      end
    end

    it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
      fill_in "ユーザー名", with: "Edit Example User"
      fill_in "メールアドレス", with: "edit-user@example.com"
      click_button "更新する"
      expect(page).to have_content "プロフィールが更新されました！"
      expect(user.reload.name).to eq "Edit Example User"
      expect(user.reload.email).to eq "edit-user@example.com"
    end

    it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      click_button "更新する"
      expect(page).to have_content 'ユーザー名を入力してください'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
      expect(user.reload.email).not_to eq ""
    end
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        create_list(:shop, 10, user: user)
        visit user_path(user)
      end

      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール')
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
      end

      it "プロフィール編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
      end

      it "ねこカフェ投稿の件数が表示されていることを確認" do
        expect(page).to have_content "ねこカフェ (#{user.shops.count})"
      end

      it "ねこカフェ投稿の情報が表示されていることを確認" do
        Shop.take(5).each do |shop|
          expect(page).to have_link shop.name
          expect(page).to have_content shop.description
          expect(page).to have_content shop.recommended_points
          expect(page).to have_content "★"
        end
      end

      it "ねこカフェ投稿のページネーションが表示されていることを確認" do
        expect(page).to have_css ".pagination"
      end
    end

    context "ユーザーのフォロー・アンフォロー処理", js: true do
      it "ユーザーのフォロー・アンフォローができること" do
        login_for_system(user)
        visit user_path(other_user)
        expect(page).to have_button 'フォローする'
        click_button 'フォローする'
        expect(page).to have_button 'フォロー中'
        click_button 'フォロー中'
        expect(page).to have_button 'フォローする'
      end
    end

    ### お気に入り登録機能に関するテスト ###

    context "お気に入り登録/解除" do
      before do
        login_for_system(user)
      end #まずはユーザーにログイン

      it "ねこカフェ投稿のお気に入り登録/解除ができること" do # ユーザーが投稿をお気に入り登録する流れを再現する
        expect(user.favorite?(shop)).to be_falsey
        user.favorite(shop)
        expect(user.favorite?(shop)).to be_truthy
        user.unfavorite(shop)
        expect(user.favorite?(shop)).to be_falsey
      end

      it "トップページからお気に入り登録/解除ができること", js: true do
        visit root_path
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{shop.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{shop.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{shop.id}/create"
      end

      it "ねこ詳細ページからお気に入り登録/解除ができること", js: true do
        visit shop_path(shop)
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{shop.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{shop.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{shop.id}/create"
      end
    end
    # 通知機能に関するテスト
    context "通知生成" do
      before do
        login_for_system(user)
      end

      context "自分以外のユーザーのねこカフェ投稿投稿に対して" do
        before do
          visit shop_path(other_shop)
        end

        it "お気に入り登録によって通知が生成されることを確認" do
          find('.like').click
          visit shop_path(other_shop)
          expect(page).to have_css 'li.no_notification'
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたのねこカフェ投稿が#{user.name}さんにお気に入り登録されました。"
          expect(page).to have_content other_shop.name
          expect(page).to have_content other_shop.description
          expect(page).to have_content other_shop.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end

        it "コメントによって通知が生成されることを確認" do
          fill_in "comment_content", with: "いいですね"
          click_button "コメント"
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたのねこカフェ投稿に#{user.name}さんがコメントしました。"
          expect(page).to have_content '「いいですね」'
          expect(page).to have_content other_shop.name
          expect(page).to have_content other_shop.description
          expect(page).to have_content other_shop.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end
      end
      # 自分のねこカフェ投稿に対しては通知が生成されないことを確認するテスト
      context "自分のねこカフェ投稿に対して" do
        before do
          visit shop_path(shop)
        end

        it "お気に入り登録によって通知が作成されないこと" do
          find('.like').click
          visit shop_path(shop)
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content 'お気に入りに登録されました。'
          expect(page).not_to have_content shop.name
          expect(page).not_to have_content shop.description
          expect(page).not_to have_content shop.created_at
        end

        it "コメントによって通知が作成されないこと" do
          fill_in "comment_content", with: "自分でコメント"
          click_button "コメント"
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content 'コメントする'
          expect(page).not_to have_content '自分でコメントする'
          expect(page).not_to have_content other_shop.name
          expect(page).not_to have_content other_shop.description
          expect(page).not_to have_content other_shop.created_at
        end
      end
    end
  end
end

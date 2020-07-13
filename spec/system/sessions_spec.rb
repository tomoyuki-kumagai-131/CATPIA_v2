require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe "ログインページ" do
    let!(:user) { create(:user) }

    before do
      visit login_path
    end

    it "「ログイン」の文字列が存在することを確認" do
      expect(page).to have_content 'ログイン'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('ログイン')
    end

    it "ヘッダーにログインページへのリンクが確認することを確認" do
      expect(page).to have_link 'ログイン', href: login_path
    end

    it "ログインフォームのラベルが正しく表示される" do
      expect(page).to have_content 'メールアドレス'
      expect(page).to have_content 'パスワード'
    end

    it "ログインフォームが正しく表示される" do
      expect(page).to have_css 'input#user_email'
      expect(page).to have_css 'input#user_password'
    end

    it "「ログインしたままにする」チェックボックスが表示される" do
      expect(page).to have_content 'ログインしたままにする'
      expect(page).to have_css 'input#session_remember_me'
    end

    it "ログインボタンが表示されることを確認" do
      expect(page).to have_button 'ログイン'
    end

    # it "無効なユーザーでログインするとログイン処理が失敗することを確認" do
    # fill_in "user_email", with: "user@example.com"
    # fill_in "user_password", with: "pass"
    # click_button "ログイン"
    # expect(page).to have_content 'メールアドレスとパスワードの組み合わせが誤っています'
    # visit root_path
    # expect(page).not_to have_content "メールアドレスとパスワードの組み合わせが誤っています"
    # end

    # it "有効なユーザーでログインする前後でヘッダーが正しく表示されていることを確認" do
    # expect(page).to have_link 'ABOUT', href: about_path
    # expect(page).to have_link 'ユーザー登録', href: signup_path
    # expect(page).to have_link 'ログイン', href: login_path
    # expect(page).not_to have_link 'ログアウト', href: logout_path

    # fill_in "user_email", with: user.email
    # fill_in "user_password", with: user.password
    # click_button "ログイン"

    # expect(page).to have_link 'ABOUT', href: about_path
    # expect(page).to have_link 'ユーザー一覧', href: users_path
    # expect(page).to have_link 'プロフィール', href: user_path(user)
    # expect(page).to have_link 'ログアウト', href: logout_path
    # expect(page).not_to have_link 'ログイン', href: login_path
    # end
  end
end

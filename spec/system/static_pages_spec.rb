require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "C A T P I Aの文字列が存在することを確認" do
        expect(page).to have_content 'C A T P I A'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      context "ねこカフェ投稿フィード", js: true do
        let!(:user) { create(:user) }
        let!(:shop) { create(:shop, user: user) }
        before do
          login_for_system(user)
        end
          
        it "新規投稿リンクが表示されていること" do
          visit root_path
          expect(page).to have_link "新規投稿", href: new_shop_path
        end

        it "投稿を削除後、削除成功のフラッシュが表示されること" do
          visit root_path
          click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '投稿が削除されました！'
        end
      end
    end
  end

  describe "アバウトページ" do
    before do
      visit about_path
    end

    it "CATPIAとは?の文字列が存在することを確認" do
      expect(page).to have_content 'CATPIAとは?'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('CATPIAとは?')
    end
  end
end

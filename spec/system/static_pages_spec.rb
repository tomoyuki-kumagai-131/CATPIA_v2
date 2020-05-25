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

          it "ねこカフェ投稿のページネーションが表示されること" do
            login_for_system(user)
            create_list(:shop, 4, user: user)
            visit root_path
            expect(page).to have_content "みんなのねこカフェ (#{user.shops.count})"
            expect(page).to have_css ".pagination"
            Shop.take(5).each do |s|
              expect(page).to have_link s.name
            end
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

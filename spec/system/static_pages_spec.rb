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

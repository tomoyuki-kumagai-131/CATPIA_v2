require "rails_helper"

RSpec.describe "ねこカフェ投稿一覧ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }

  context "ログインしているユーザー" do
    it "レスポンスが正常に表示されることを確認" do
      login_for_request(user)
      get shops_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('shops/index')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすることを確認" do
      get shops_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_url
    end
  end
end

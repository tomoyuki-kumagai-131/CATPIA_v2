require 'rails_helper'

RSpec.describe "ユーザー一覧ページ", type: :request do
  let!(:user) { create(:user) } 

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されることを確認する" do
      login_for_request(user)
      get users_path
      expect(response).to render_template('users/index')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログインページへリダイレクトすることを確認する" do
      get users_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end

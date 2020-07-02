require "rails_helper"

RSpec.describe "ユーザーの削除", type: :request do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }

  context "管理者ユーザーの場合" do
    it "ユーザーを削除後、ユーザー一覧ページにリダイレクト" do
      login_for_request(admin_user)
      expect { delete user_path(user) }.to change(User, :count).by(-1)
      redirect_to users_url
      follow_redirect!
      expect(response).to render_template('users/index')
    end
  end

  context "管理者以外のユーザーの場合" do
    it "自分のアカウントを削除できること" do # 削除後トップページに遷移することを確認
      login_for_request(user)
      expect { delete user_path(user) }.to change(User, :count).by(-1)
      redirect_to root_url
    end

    it "自分以外のユーザーアカウントを削除しようとすると、トップページにリダイレクトすること" do
      login_for_request(user)
      expect { delete user_path(other_user) }.not_to change(User, :count)
      expect(response).to redirect_to root_url
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ユーザーアカウントを削除しようとすると、ログインページへリダイレクトすること" do
      expect { delete user_path(other_user) }.not_to change(User, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_url
    end
  end
end

# 覚え root_url は、redirect_toのときに使う(絶対パス)

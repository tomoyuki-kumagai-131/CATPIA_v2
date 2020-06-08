require "rails_helper"

RSpec.describe "通知機能", type: :request do
  let!(:user) { create(:user) }

  describe "通知一覧ページ表示" do
    context "ログインしているユーザーの場合" do
      before do
        login_for_request(user)
      end

      it "レスポンスが正常に表示されること" do
        get notifications_path
        expect(response).to render_template('notifications/index')
      end
    end

    context "ログインしていないユーザーの場合" do
      it "レスポンスが正常に表示されること" do
        get notifications_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_url
      end
    end
  end
end

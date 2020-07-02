require "rails_helper"

RSpec.describe  "ねこカフェ投稿の削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }

  context "ログイン中に、自分の投稿を削除する" do
    it "削除処理が成功し、トップページにリダイレクトすること" do
      login_for_request(user)
      expect { delete shop_path(shop) }.to change(Shop, :count).by(-1)
      redirect_to user_path(user)
      follow_redirect!
      expect(response).to render_template('static_pages/home')
    end
  end

  context "ログイン中に、他人の投稿を削除する" do
    it "削除処理が失敗し、トップページにリダイレクトすること" do
      login_for_request(other_user)
      expect { delete shop_path(shop) }.not_to change(Shop, :count) # 削除することはできない
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
    end
  end

  context "ログインしていない場合" do # ログインしていないのでまずはログインさせる
    it "ログインページにリダイレクトすること" do
      expect { delete shop_path(shop) }.not_to change(Shop, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_url
    end
  end
end

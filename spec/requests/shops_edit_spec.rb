require "rails_helper"

RSpec.describe "ねこカフェ編集", type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get edit_shop_path(shop)
      expect(response).to render_template('shops/edit')
      patch shop_path(shop), params: { shop: { name: "ひとやすみ",
                                              description: "世界の珍しい猫が集まっています。",
                                              address: "名古屋市中区栄１−１−１",
                                              recommended_points: "黒猫の「くろくん」が可愛いですよ。",
                                              web_page: "https://google.com",
                                              rating: 5 } }
      redirect_to shop
      follow_redirect!
      expect(response).to render_template('shops/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      # 編集
      get edit_shop_path(shop)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      # 更新
      patch shop_path(shop), params: { shop: { name: "ひとやすみ",
                                        description: "世界の珍しい猫が集まっています。",
                                        address: "名古屋市中区栄１−１−１",
                                        recommended_points: "黒猫の「くろくん」が可愛いですよ。",
                                        web_page: "https://google.com",
                                        rating: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end

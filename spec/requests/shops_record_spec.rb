require 'rails_helper'

RSpec.describe "ねこカフェ登録", type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test-shop.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }

  context "ログインしているユーザーの場合" do
    before do
      login_for_request(user)
      get new_shop_path
    end

    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get new_shop_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('shops/new')
    end

    it "有効なねこカフェデータで登録できること" do
      expect {
        post shops_path, params: { shop: { name: "ひとやすみ",
                                           description: "世界の珍しい猫が集まっています。",
                                           address: "名古屋市中区栄１−１−１",
                                           recommended_points: "黒猫の「くろくん」が可愛いですよ。",
                                           web_page: "https://google.com",
                                           rating: 5,
                                           picture: picture } }
      }.to change(Shop, :count).by(1)
      follow_redirect!
      expect(response).to render_template('shops/show')
    end

    it "無効なデータでは登録できないこと" do
      expect {
        post shops_path, params: { shop: { name: "",
                                           description: "世界の珍しい猫が集まっています。",
                                           address: "名古屋市中区栄１−１−１",
                                           recommended_points: "黒猫の「くろくん」が可愛いですよ。",
                                           web_page: "https://google.com",
                                           rating: 5,
                                           picture: picture } }
      }.to change(Shop, :count).by(0)
      expect(response).to render_template('shops/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトされること" do
      get new_shop_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end

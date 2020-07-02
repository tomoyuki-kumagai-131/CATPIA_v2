require "rails_helper"

RSpec.describe "ねこカフェ編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }
  let(:picture2_path) { File.join(Rails.root, 'spec/fixtures/test-shop2.jpg') } # 追記/写真投稿
  let(:picture2) { Rack::Test::UploadedFile.new(picture2_path) } # 追記/写真投稿

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること・フレンドリーフォワーディング" do
      get edit_shop_path(shop)
      login_for_request(user)
      expect(response).to redirect_to edit_shop_url(shop)
      patch shop_path(shop), params: { shop: { name: "ひとやすみ",
                                               description: "世界の珍しい猫が集まっています。",
                                               address: "名古屋市中区栄１−１−１",
                                               recommended_points: "黒猫の「くろくん」が可愛いですよ。",
                                               web_page: "https://google.com",
                                               rating: 5,
                                               picure: picture2 } }
      redirect_to shop
      follow_redirect!
      expect(response).to render_template('shops/show')
    end
  end

  context "別のアカウントユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      # 編集処理
      login_for_request(other_user)
      get edit_shop_path(shop)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
      # 更新処理
      patch shop_path(shop), params: { shop: { name: "ひとやすみ",
                                               description: "世界の珍しい猫が集まっています。",
                                               address: "名古屋市中区栄１−１−１",
                                               recommended_points: "黒猫の「くろくん」が可愛いですよ。",
                                               web_page: "https://google.com",
                                               rating: 4 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
    end
  end
end

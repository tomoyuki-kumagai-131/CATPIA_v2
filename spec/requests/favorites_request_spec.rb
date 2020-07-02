require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop) }

  describe "お気に入り一覧ページの表示" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_for_request(user)
        get favorites_path
        expect(response).to have_http_status "200" # 成功
        expect(response).to render_template('favorites/index') # favoritesフォルダのindexの表示
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get favorites_path # ログインせずにお気に入り一覧画面を開く
        expect(response).to have_http_status "302" # 弾かれる
        expect(response).to redirect_to login_url # ログインページへリダイレクト
      end
    end
  end

  describe "お気に入り登録処理" do
    context "ログインしていない場合" do
      it "お気に入り登録は実行できずに、ログインページへリダイレクトすること" do
        expect {
          post "/favorites/#{shop.id}/create"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_url
      end

      it "お気に入り登録解除はできず、ログインページへリダイレクトすること" do
        expect {
          delete "/favorites/#{shop.id}/destroy"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      before do
         login_for_request(user)
      end

      # ログイン中にお気に入り登録・解除ができるかテスト #

      it "ねこカフェのお気に入り登録ができること" do
        expect {
          post "/favorites/#{shop.id}/create"
        }.to change(user.favorites, :count).by(1)
      end

      it "ねこカフェのAjaxによるお気に入り登録ができること" do
        expect {
          post "/favorites/#{shop.id}/create", xhr: true
        }.to change(user.favorites, :count).by(1)
      end

      it "ねこカフェのお気に入り解除ができること" do
        user.favorite(shop)
        expect {
          delete "/favorites/#{shop.id}/destroy"
        }.to change(user.favorites, :count).by(-1)
      end

      it "ねこカフェのAjaxを用いたお気に入り解除ができること" do
        user.favorite(shop)
        expect {
          delete "/favorites/#{shop.id}/destroy", xhr: true
        }.to change(user.favorites, :count).by(-1)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop) }

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
  end
end

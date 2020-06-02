require 'rails_helper'

RSpec.describe "ユーザーフォロー機能", type: :request do
  let(:user) { create(:user) }

  context "ログインしていない場合" do
    it "followingページへ飛ぶとログインページへリダイレクトすること" do
      get following_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "followersページへ飛ぶとログインページへリダイレクトすること" do
      get followers_user_path(user)
      expect(response).to redirect_to login_path
    end

    # logged_in_user が動作しているか確認 #
    it "createアクションは実行できずに、ログインページへリダイレクトすること" do
      expect {
        post relationships_path
      }.not_to change(Relationship, :count)
      expect(response).to redirect_to login_path
    end

    it "destroyアクションは実行できず、ログインページへリダイレクトすること" do
      expect {
        delete relationship_path(user)
      }.not_to change(Relationship, :count)
      expect(response).to redirect_to login_path
    end
  end
end

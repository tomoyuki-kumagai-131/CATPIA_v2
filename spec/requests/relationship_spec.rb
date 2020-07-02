require 'rails_helper'

RSpec.describe "ユーザーフォロー機能", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context "ログインしている場合" do
    before do
      login_for_request(user)
    end

    it "ユーザーのフォローができること" do
      expect {
        post relationships_path, params: { followed_id: other_user.id }
      }.to change(user.following, :count).by(1)
    end

    it "ユーザーのAjaxを用いたフォローができること" do # xhr: true によってAjaxwのリクエストを送ることができる。
      expect {
        post relationships_path, xhr: true, params: { followed_id: other_user.id }
      }.to change(user.following, :count).by(1)
    end

    it "ユーザーのアンフォローができること" do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect {
        delete relationship_path(relationship)
      }.to change(user.following, :count).by(-1)
    end

    it "ユーザーのAjaxを用いたアンフォローができること" do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect {
        delete relationship_path(relationship), xhr: true
      }.to change(user.following, :count).by(-1)
    end
  end

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

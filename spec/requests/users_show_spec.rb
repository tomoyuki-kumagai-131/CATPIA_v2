require "rails_helper"

RSpec.describe "プロフィールページ", type: :request do #リクエストスペック
  let!(:user) { create(:user) }

  it "正常にレスポンスが表示されること" do
    get user_path(user)
    expect(response).to render_template('users/show')
  end
end
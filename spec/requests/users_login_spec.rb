require 'rails_helper'

RSpec.describe "ログイン", type: :request do
  let!(:user) { create(:user) }

  it "正常なレスポンスを返すこと" do
    get login_path
    expect(response).to be_success
    expect(response).to have_http_status "200"
  end

  it "有効なユーザーでログイン＆ログアウト" do
    get login_path
    post login_path, params: { session: { email: user.email,
                                          password: user.password } }
    redirect_to user
    follow_redirect!
    expect(response).to render_template('users/show')
    expect(is_logged_in?).to be_truthy
    delete logout_path
    expect(is_logged_in?).not_to be_truthy
    redirect_to root_url
    delete logout_path
    follow_redirect!
  end

  it "無効なユーザーでログイン" do
    get login_path
    post login_path, params: { session: { email: "xxx@example.com",
                                          password: user.password } }
    expect(is_logged_in?).not_to be_truthy
  end
end

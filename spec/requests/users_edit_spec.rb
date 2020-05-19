require "rails_helper"

RSpec.describe "プロフィール編集", type: :request do
  let!(:user) { create(:user) }

  before do
    get edit_user_path(user)
  end

  it "有効なプロフィール編集をすること" do
    expect(response).to render_template('users/edit')
    patch user_path(user), params: { user: { name: "Example User",
                                            email: "user@example.com" } }
    redirect_to user
    follow_redirect!
    expect(response).to render_template('users/show')
  end

  it "無効なプロフィール編集をすること" do
    expect(response).to render_template('users/edit')
    patch user_path(user), params: { user: { name: "",
                                            email: "hoge@hoge" } } # ネーム欄が空欄

    expect(response).to render_template('users/edit')
  end
end

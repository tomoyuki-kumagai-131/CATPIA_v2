require 'rails_helper'

RSpec.describe "静的ページ", type: :request do
  describe "トップページ" do
    it "正常なレスポンスを返すこと" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "ABOUTページ" do
    it "正常なレスポンスを返すこと" do
      get about_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end
end

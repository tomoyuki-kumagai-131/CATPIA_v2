class ShopsController < ApplicationController
  before_action :logged_in_user # ログインユーザーのみ投稿可能

  # ねこカフェ投稿アクション
  def new
    @shop = Shop.new
  end
end

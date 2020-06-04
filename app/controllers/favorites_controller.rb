class FavoritesController < ApplicationController
  before_action :logged_in_user

  # お気に入り登録した投稿の一覧表示
  def index
    @favorites = current_user.favorites
  end

  # お気に入り登録（create）アクション
  def create
    @shop = Shop.find(params[:shop_id])
    @user = @shop.user
    current_user.favorite(@shop)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  #お気に入り登録解除(destroy)アクション
  def destroy
    @shop = Shop.find(params[:shop_id])
    current_user.favorites.find_by(shop_id: @shop.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end

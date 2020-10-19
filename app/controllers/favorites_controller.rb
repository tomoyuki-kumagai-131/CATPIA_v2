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
    # 自分以外のユーザーからお気に入り登録があった場合のみ通知する (自分がお気に入り登録しても通知しない)
    if @user != current_user
      @user.notifications.create(shop_id: @shop.id, variety: 1, # お気に入り登録は[ variety=1 ]
                                 from_user_id: current_user.id)
      @user.update_attribute(:notification, true) # デフォルトはfalse,通知ありだとtrueを返す
    end
    #@favorites_count = Favorite.where(shop_id: params[:shop_id]).count
    @favorites_count = Favorite.where(shop_id: @shop.id).count
  end

  # お気に入り登録解除(destroy)アクション
  def destroy
    @shop = Shop.find(params[:shop_id])
    current_user.favorites.find_by(shop_id: @shop.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
    @favorites_count = Favorite.where(shop_id: params[:shop_id]).count
    @favorites_count = Favorite.where(shop_id: @shop.id).count
  end
end

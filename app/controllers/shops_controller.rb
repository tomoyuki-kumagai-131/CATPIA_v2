class ShopsController < ApplicationController
  before_action :logged_in_user # ログインユーザーのみ投稿可能

  # ねこカフェ投稿アクション
  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.build(shop_params)
    if @shop.save
      flash[:success] = "ねこカフェの投稿が完了しました！"
      redirect_to root_url
  
    else
      render 'shops/new'
  end
end

  private

    def shop_params
      params.require(:shop).permit(:name, :description, :address, :recommended_points, :web_page, :rating)
    end
end

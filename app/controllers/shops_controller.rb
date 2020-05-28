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
      redirect_to shop_path(@shop) # 投稿後、投稿詳細画面へ遷移
    else
      render 'shops/new'
  end

  def show
    @shop = Shop.find(params[:id])
  end
end

  private
    # 登録できる項目をshop_paramsメソッドで定義する
    def shop_params
      params.require(:shop).permit(:name, :description, :address, :recommended_points, :web_page, :rating)
    end
end

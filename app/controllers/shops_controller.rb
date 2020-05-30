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
  end

  # ねこカフェ投稿詳細ページへ
  def show
    @shop = Shop.find(params[:id])
  end

  # ねこカフェ投稿編集処理
  def edit
    @shop = Shop.find(params[:id])
  end

  # ねこカフェ投稿更新処理
  def update
    @shop = Shop.find(params[:id])
    if @shop.update_attributes(shop_params)
      flash[:success] = "ねこカフェ情報が更新されました！"
      redirect_to @shop # 更新後、詳細ページへ遷移
    else
      render 'edit' # 更新できなかった場合は編集画面を表示
    end
  end

  private
    # 登録できる項目をshop_paramsメソッドで定義する
    def shop_params
      params.require(:shop).permit(:name, :description, :address, :recommended_points, :web_page, :rating)
    end
end

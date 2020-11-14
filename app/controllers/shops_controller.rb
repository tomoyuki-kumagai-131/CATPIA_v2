class ShopsController < ApplicationController
  before_action :logged_in_user # ログインユーザーのみ投稿可能
  before_action :correct_user, only: [:edit, :update] # 投稿した本人のみがedit,updateを行える

  # ねこカフェ投稿アクション
  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.build(shop_params)
    if @shop.save
      flash[:success] = "投稿が完了しました！"
      redirect_to shop_path(@shop) # 投稿後、投稿詳細画面へ遷移
    else
      render 'shops/new'
    end
  end

  # 猫カフェ検索後・タグ絞り込み
  def index
    #@favorites_count = Favorite.where(shop_id: params[:shop_id]).count
    if params[:tag_name]
      @shops = Shop.tagged_with(params[:tag_name]).page(params[:page])
    end
    @tags = Shop.tag_counts_on(:tags)
  end

  def search
  end

  def rank
    #@all_ranks = Shop.find(Favorit e.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @all_ranks = Shop.all.sort {|a,b| b.favorited_users.count <=> a.favorited_users.count}
  end

  # ねこカフェ投稿詳細ページへ
  def show
    @shop = Shop.find(params[:id])
    @comment = Comment.new # コメント機能
    @hash = Gmaps4rails.build_markers(@shop) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow shop.name
    end
    #@favorites_count = Favorite.where(shop_id: params[:shop_id]).count
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

  # ねこカフェ投稿削除処理
  def destroy
    @shop = Shop.find(params[:id])
    if current_user.admin? || current_user?(@shop.user)
      @shop.destroy
      flash[:success] = "投稿が削除されました！"
      redirect_to request.referrer == user_url(@shop.user) ? user_url(@shop.user) : root_url
    else
      flash[:danger] = "他人の投稿は削除できません！"
      redirect_to root_url
    end
  end

  def mapindex
    @shops = Shop.all
    @hash = Gmaps4rails.build_markers(@shop) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow shop.name
    end
  end

  def random
    @random = Shop.order("RAND()").all
  end

  def tags
    @tags = Shop.includes(:taggings).tag_counts_on(:tags)
  end

  private

    # 登録できる項目をshop_paramsメソッドで定義する
    def shop_params
      params.require(:shop).permit(:name, :description, :address, :recommended_points, :web_page, :rating, :picture, :latitude, :longitude, :tag_list)
    end

    # 現在のユーザーが更新対象のねこカフェ投稿を保有しているかどうか確認する
    def correct_user
      @shop = current_user.shops.find_by(id: params[:id])
      redirect_to root_url if @shop.nil?
    end
end

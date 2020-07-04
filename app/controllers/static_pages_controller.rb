class StaticPagesController < ApplicationController
  # @feed_items ...feedメソッドの各要素はShopクラスを持つため、renderによりpartialを呼び出せる
  def home
    if logged_in?
      @feed_items = current_user.feed.page(params[:page]).per(15)
    end
  end

  def about
  end
end

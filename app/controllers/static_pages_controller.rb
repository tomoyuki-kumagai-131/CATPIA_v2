class StaticPagesController < ApplicationController
  # @feed_items ...feedメソッドの各要素はShopクラスを持つ
  def home
    if logged_in?
      @feed_items = current_user.feed.page(params[:page]).per(6)
    end
  end

  def about
  end
end

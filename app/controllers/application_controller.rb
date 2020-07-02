class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_search
    if logged_in?
      @search_word = params[:q][:name_cont] if params[:q]
      @q = current_user.feed.page(params[:page]).ransack(params[:q])
      @shops = @q.result(distinct: true)
    end
  end

  private

    # ログイン済ユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location # sessions_helperのメソッド
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end

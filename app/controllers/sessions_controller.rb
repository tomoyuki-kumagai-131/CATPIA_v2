class SessionsController < ApplicationController
  def new
  end

  def new2
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) # チェックがついている時限定でRemember me有効化
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが誤っています'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? # ログイン時のみログアウト可能
    redirect_to root_url
  end
end

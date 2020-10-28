class SessionsController < ApplicationController
  def new
  end

  def new2
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "ログインしました！"
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else
      flash[:error] = "メールアドレスとパスワードの組み合わせが誤っています"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = "ログアウトしました！" # ログイン時のみログアウト可能
    redirect_to root_url
  end

  def recruit_login # かんたんログイン機能(直接遷移)
    user = User.find_by(email: 'recruit1@example.com')
    log_in user
    flash[:info] = 'ゲストユーザーとしてログインしました！'
    redirect_to root_path
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user#登録後すぐにログインできる
      flash[:success] = 'CATPIAへようこそ!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_update)
      flash[:success] = "プロフィールが更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
  end

  private
    # ユーザー新規作成時に許可する属性
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # プロフィール編集時に許可する属性
    def user_params_update
      params.require(:user).permit(:name, :email)
    end
end

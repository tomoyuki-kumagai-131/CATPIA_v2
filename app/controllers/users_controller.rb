class UsersController < ApplicationController
  # pagyを読み込む
  include Pagy::Backend
  # ログインが必要
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  # 他人の操作は不可にする
  before_action :correct_user,   only: [:edit, :update]
  
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

  def index # ユーザー一覧表示アクション pagy
    @pagy, @users = pagy(User.all)
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

    # 正しいユーザーかどうか確認するメソッド
    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:danger] = "このページにはアクセスできません"
        redirect_to(root_url)
      end
    end
end

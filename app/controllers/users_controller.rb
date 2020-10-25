class UsersController < ApplicationController
  # ログインが必要
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  # 他人の操作は不可
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @shops = Shop.page(params[:page]).per(10)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      #無ければ作る
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
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
      flash[:info] = "プロフィールが更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # フォロー
  def following
    @title = "フォロー中"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  # フォロワー
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  # ユーザー削除処理 #
  def destroy
    @user = User.find(params[:id])
    # 管理者ユーザーの場合
    if current_user.admin?
      @user.destroy
      flash[:success] = "ユーザーの削除に成功しました"
      redirect_to users_url
    # 管理者ユーザーではなく、自分のアカウントの場合 削除後rootに。
    elsif current_user?(@user)
      @user.destroy
      flash[:succcess] = "自分のアカウントを削除しました"
      redirect_to root_url
    else # 他人がアカウントを削除しようとした場合
      flash[:danger] = "他人のアカウントは削除できません"
      redirect_to root_url
    end
  end

  def index # ユーザー一覧表示アクション
    @users = User.all.order(created_at: :desc)
    @users = User.page(params[:page]).per(5)
  end

  private

    # ユーザー新規作成時に許可する属性
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    # プロフィール編集時に許可する属性
    def user_params_update
      params.require(:user).permit(:name, :email, :image, :introduction)
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

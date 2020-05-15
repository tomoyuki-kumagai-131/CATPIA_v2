class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:id])#特定のIDデータを取得する
    if @user.save
      flash[:success] = "CATPIAへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def index
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end

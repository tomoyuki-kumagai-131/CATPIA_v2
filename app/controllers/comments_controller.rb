class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @shop = Shop.find(params[:shop_id])
    @user = @shop.user
    @comment = @shop.comments.build(user_id: current_user.id, content: params[:comment][:content])
      if !@shop.nil? && @comment.save
        flash[:success] = "コメントを投稿しました！"
      else
        flash[:danger] =  "空のコメントは投稿できません！"
      end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @shop = @comment.shop
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました！"
    end
    redirect_to shop_url(@shop)
  end
end

class Public::FavoritesController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.build(post: @post)
    if @favorite.save
      redirect_to @post, notice: 'いいねしました。'
    else
      redirect_to @post, alert: 'いいねに失敗しました。'
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(post_id: params[:post_id])
    @favorite.destroy
    redirect_to @favorite.post, notice: 'いいねを解除しました。'
  end
  
end

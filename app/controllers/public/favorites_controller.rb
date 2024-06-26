class Public::FavoritesController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.build(post: @post)
    if @favorite.save
      redirect_to @post, notice: 'お気に入りに追加しました。'
    else
      redirect_to @post, alert: 'お気に入りの追加に失敗しました。'
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(post_id: params[:post_id])
    @favorite.destroy
    redirect_to @favorite.post, notice: 'お気に入りを解除しました。'
  end
  
end

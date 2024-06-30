class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :authenticate_user!

  def mypage
    current_user.get_image
    @posts = current_user.posts.includes(:comments).page(params[:post_page]).per(10)
    @comments = current_user.comments.page(params[:comment_page]).per(10)
  end
  
  def following
    @user = User.find(params[:id])
    @followees = @user.followees.page(params[:page]).per(10)  # ページネーションの追加
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(10)  # ページネーションの追加
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites.includes(:post).page(params[:page]).per(10)  # お気に入りの投稿を取得し、ページネーションを追加
  end
  
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10) # 1ページに表示する投稿数を設定
    @comments = @user.comments.page(params[:page]).per(10) # 1ページに表示するコメント数を設定
  
    # カレントユーザーが表示しているユーザーと同じ場合はmypageにリダイレクト
    if @user == current_user
      redirect_to mypage_path
    end
  end

  # GET /users/:id/edit
  def edit
    @user = current_user
    redirect_to root_path, alert: 'Access denied.' unless @user == current_user
  end

  # PATCH /users/:id
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User profile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Callback to set user
  def set_user
    @user = User.find(params[:id])
  end

  # Strong parameters for user
  def user_params
    params.require(:user).permit(:name, :email, :user_image,)
  end
end

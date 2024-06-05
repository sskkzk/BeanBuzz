class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def mypage
    current_user.get_image
    @posts = current_user.posts
  end
  
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
    @posts = @user.posts  # ユーザーの投稿一覧
  end

  # GET /users/:id/edit
  def edit
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

  # コールバック関数で共通のセットアップ
  def set_user
    @user = User.find(params[:id])
  end

  # ユーザーの安全なパラメータ
  def user_params
    params.require(:user).permit(:name, :email, :user_image, :bio)
  end
end

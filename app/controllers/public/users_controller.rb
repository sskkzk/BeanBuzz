class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :favorites]
  before_action :authenticate_user!

  def mypage
    current_user.get_image
    @posts = current_user.posts.includes(:comments).page(params[:post_page]).per(10)
    @comments = current_user.comments.page(params[:comment_page]).per(10)
  end
  
  def following
    @followees = @user.followees.page(params[:page]).per(10)  # ページネーションの追加
  end

  def followers
    @followers = @user.followers.page(params[:page]).per(10)  # ページネーションの追加
  end

  def favorites
    if @user.present?
      @favorites = @user.favorites.includes(:post).page(params[:page]).per(10)  # お気に入りの投稿を取得し、ページネーションを追加
    else
      redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
    end
  end
  
  # GET /users
  def index
    if params[:search_users]
      @users = User.where('name LIKE ?', "%#{params[:search_users]}%").page(params[:page]).per(30)
    else
      @users = User.page(params[:page]).per(30)
    end
  end

  # GET /users/:id
  def show
    if current_user == @user
      redirect_to mypage_path
      return
    end
  
    if @user.is_private && !current_user.following?(@user)
      redirect_to root_path, alert: "このユーザーのプロフィールは非公開です。"
      return
    end

    @posts = @user.posts.page(params[:page]).per(10)
    @comments = @user.comments.page(params[:page]).per(10)
  end

  # GET /users/:id/edit
  def edit
    redirect_to root_path, alert: 'Access denied.' unless @user == current_user
  end

  # PATCH /users/:id
  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: '設定が更新されました。'
    else
      render :edit
    end
  end 

  # DELETE /users/:id
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'ユーザーを削除しました。'
  end

  private

  # Callback to set user
  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path, alert: "ユーザーが見つかりません。" unless @user
  end

  # Strong parameters for user
  def user_params
    params.require(:user).permit(:name, :email, :user_image, :is_private)
  end
end



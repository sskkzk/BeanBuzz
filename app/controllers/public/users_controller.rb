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
    if params[:search_users]
      @users = User.where('name LIKE ?', "%#{params[:search_users]}%").page(params[:page]).per(30)
    else
      @users = User.page(params[:page]).per(30)
    end
  end

  # GET /users/:id
  def show
  @user = User.find(params[:id])
  
    # 現在のユーザーが対象のユーザーの場合はマイページへリダイレクト
    if current_user == @user
      redirect_to mypage_path
      return # ここで処理を終了させる
    end
  
    # 鍵垢関係の処理をスキップするための追加チェック
    if @user.is_private && !current_user.following?(@user)
      redirect_to root_path, alert: "このユーザーのプロフィールは非公開です。"
      return # ここで処理を終了させる
    end

  # その他のプロフィールページの処理...
  end

  # GET /users/:id/edit
  def edit
    @user = current_user
    redirect_to root_path, alert: 'Access denied.' unless @user == current_user
  end

  # PATCH /users/:id
  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: '設定が更新されました。'
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
    params.require(:user).permit(:name, :email, :user_image, :is_private)
  end
  

end

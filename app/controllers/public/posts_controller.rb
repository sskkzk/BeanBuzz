class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # Deviseのヘルパーメソッド、except: [:index, :show] 以外はログイン画面へ
  before_action :correct_user, only: [:edit, :update, :destroy]  # ログインユーザーか確認

  def index
    @posts = if params[:search_header]
       Post.search(params[:search_header]).page(params[:page]).per(10) #kaminariの記述
     else
       sorted_posts(Post.page(params[:page]).per(10))
     end
  end


  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: '投稿が正常に作成されました。'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: '投稿が正常に削除されました。'
  end

  private

  def post_params
    params.require(:post).permit(:bean_origin, :bean_roast, :bean_acidity, :bean_bitter, :bean_extraction, :bean_title, :bean_body, :bean_image)
  end

  # 現在のユーザーがその投稿の所有者であるかどうかを確認するメソッド
  def correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to(posts_path, alert: '他のユーザーの投稿を編集することはできません。')
    end
  end
  
  def sorted_posts(posts)
    case params[:sort]
    when 'newest'
      posts.order(created_at: :desc)
    when 'oldest'
      posts.order(created_at: :asc)
    when 'roast_high'
      posts.order(bean_roast: :desc)
    when 'roast_low'
      posts.order(bean_roast: :asc)
    when 'bitter_high'
      posts.order(bean_bitter: :desc)
    when 'bitter_low'
      posts.order(bean_bitter: :asc)
    when 'acidity_high'
      posts.order(bean_acidity: :desc)
    when 'acidity_low'
      posts.order(bean_acidity: :asc)
    else
      posts
    end
  end

end


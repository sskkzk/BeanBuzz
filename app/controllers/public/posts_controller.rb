class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = Post.page(params[:page]).per(10)
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
      redirect_to @post, notice: '投稿が正常に作成されました。'
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
end


class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
 
  def index
    if params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @post.get_image
    @my_comment = @post.comments.find_by(user_id: current_user.id) if user_signed_in?
    @other_comments = @post.comments.where.not(user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
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
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:bean_origin, :bean_roast, :bean_acidity, :bean_bitter, :bean_extraction, :bean_title, :bean_body, :bean_image)
  end
  
end

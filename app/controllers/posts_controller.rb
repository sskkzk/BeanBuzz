class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
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
    params.require(:post).permit(:bean_origin, :bean_roast, :bean_taste, :bean_extraction, :bean_title, :bean_body, :bean_image) 
  end
  
  
end

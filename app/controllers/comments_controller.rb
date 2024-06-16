class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = @post.comments.new
    
  end

  def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
    redirect_to post_path(@post), notice: 'Comment was successfully created.'
  else
    render 'posts/show'
  end
end


  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'コメントを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to post_path(@post), notice: 'コメントを削除しました。'
    else
      redirect_to post_path(@post), alert: 'コメントの削除に失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Post not found."
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment_body)
  end
end

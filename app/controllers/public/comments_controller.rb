class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.find_or_initialize_by(user: current_user)
    @comment.assign_attributes(comment_params)

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントが投稿されました。'
    else
      redirect_to post_path(@post), alert: 'コメントの投稿に失敗しました。'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: 'コメントを更新しました。'
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


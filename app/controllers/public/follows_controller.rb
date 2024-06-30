class Public::FollowsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to @user, notice: 'フォローしました。'
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to @user, alert: 'フォローを解除しました。'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end

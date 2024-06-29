class Public::FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followee_id])
    current_user.followees << user
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:id])
    current_user.followees.delete(user)
    redirect_back(fallback_location: root_path)
  end
  
end

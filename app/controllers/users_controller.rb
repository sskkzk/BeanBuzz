class UsersController < ApplicationController
  
  private
  def user_params
    params.require(:user).permit(:title, :body, :user_image)  end
end

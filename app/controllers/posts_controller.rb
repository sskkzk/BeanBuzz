class PostsController < ApplicationController
  private
  def post_params
    params.require(:post).permit(:been_origin, :been_roast, :been_taste, :been_extraction, :been_title, :been_body, :coffee_image)  end
end

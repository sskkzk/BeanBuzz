class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    posts_path # サインイン後に投稿のインデックスページにリダイレクト
  end

  def after_sign_out_path_for(resource_or_scope)
    homes_about_path # サインアウト後にhomesのaboutページにリダイレクト
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_image])
  end
end

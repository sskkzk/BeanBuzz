# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    posts_path # サインイン後に投稿のインデックスページにリダイレクト
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # サインアウト後にhomesのtopページにリダイレクト
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_image])
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

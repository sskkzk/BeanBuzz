# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    posts_path # サインイン後に投稿のインデックスページにリダイレクト
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :user_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :user_image])
  end

  # パスワードを変更しない場合には current_password を要求しない
  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params.except(:current_password))
    else
      resource.update_with_password(params)
    end
  end

  # 編集成功後にmypageにリダイレクトする
  def after_update_path_for(resource)
    mypage_path
  end
end


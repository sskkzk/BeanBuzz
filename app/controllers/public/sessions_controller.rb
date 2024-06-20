class Public::SessionsController < Devise::SessionsController
  before_action :check_user_status, only: [:create]

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

  private

  def check_user_status
    user = User.find_by(email: params[:user][:email])
    if user && !user.status
      redirect_to new_user_session_path, alert: 'このアカウントはブロックされています。'
    end
  end
  
end

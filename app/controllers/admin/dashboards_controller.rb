class Admin::DashboardsController < ApplicationController
  
  before_action :authenticate_admin!
   
  def index
     @users = User.page(params[:page]).per(10)  # 1ページあたり10ユーザーを表示
  end
  
  layout 'admin' # ここを追加
  
end

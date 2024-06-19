class Admin::DashboardsController < ApplicationController
  
  before_action :authenticate_admin!
   
  def index
    @users = User.all
  end
  
  layout 'admin' # ここを追加
  
end

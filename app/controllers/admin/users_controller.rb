class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:toggle_status, :destroy]

  def toggle_status
    @user.update(status: !@user.status)
    redirect_to admin_dashboards_path, notice: 'ユーザーのステータスが更新されました。'
  end

  def destroy
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

class ApplicationController < ActionController::Base
  before_action :configure_authentication

  protect_from_forgery with: :exception

  private

  def configure_authentication
    if admin_controller?
      authenticate_admin!
    end
  end

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

end


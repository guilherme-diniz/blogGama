class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize
    authenticate_user!
  end

  def authorize_admin
    authenticate_user!
  end

  def current_admin_user
    @current_admin_user ||= current_user if user_signed_in? && current_user.role == :admin
  end
end

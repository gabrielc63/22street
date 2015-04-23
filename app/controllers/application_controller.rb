class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  # include BootstrapFlashHelper
  def return_point(default)
    redirect_to session[:return_point] ? session[:return_point] : default
    session.delete(:return_point)
  end

  def set_return_point(path)
    session[:return_point] = path
  end
end

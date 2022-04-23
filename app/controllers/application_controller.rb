class ApplicationController < ActionController::Base

  # before_action :require_login
  # layout 'application'

  helper_method :current_user
  helper_method :current_member
  helper_method :logged_in?
  helper_method :logged_in_member?

  def require_login
    redirect_to new_user_path unless session.include? :id
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  def current_member
    @current_member ||= Member.find(session[:id]) if session[:id]
  end


  def logged_in?    
    !current_user.nil? || !current_member.nil?
  end

  def logged_in_member?    
    !current_member.nil?
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

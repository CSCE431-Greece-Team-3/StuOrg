class ApplicationController < ActionController::Base

  # before_action :require_login
  # layout 'application'

  helper_method :current_user
  helper_method :current_member
  helper_method :logged_in?
  helper_method :logged_in_member?

  # makes the org/member to be logged in when using the application
  def require_login
    redirect_to new_user_path unless session.include? :id
  end

  # gets the current org logged in 
  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  # gets the current member logged in
  def current_member
    @current_member ||= Member.find(session[:id]) if session[:id]
  end

  # checks to see if anyone is logged in currently
  def logged_in?    
    !current_user.nil? || !current_member.nil?
  end

  # checks to see if a member is logged in
  def logged_in_member?    
    !current_member.nil?
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

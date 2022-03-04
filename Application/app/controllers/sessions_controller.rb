class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new; end

  def create
    @user = User.find_by(username: params[:session][:username].downcase)
    @member = Member.find_by(username: params[:session][:username].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_type] = "Organization"
      session[:id] = @user.id
      # puts @user.id
      redirect_to '/profile'
    else
      if @member && @member.authenticate(params[:session][:password])
        session[:user_type] = "Member"
        session[:id] = @member.id
        redirect_to @member
      else
        flash[:notice] = 'Invalid email/password combination'
        redirect_to '/sign_in'
      end
    end 
  end

  def destroy
    session[:id] = nil
    session[:user_type] = nil
    # flash[:notice] = "You have been signed out!"
    redirect_to '/'
  end
end

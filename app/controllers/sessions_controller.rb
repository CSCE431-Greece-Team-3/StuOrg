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
    session[:cart] = nil
    # flash[:notice] = "You have been signed out!"
    redirect_to '/'
  end
  
  def omniauth
    if (auth2 == "user")
      @user = User.from_omniauth(auth)
      @user.save
      session[:user_type] = "Organization"
      session[:id] = @user.id
      redirect_to '/profile'
    elsif (auth2 == "member") 
      @member = Member.from_omniauth(auth)
      @member.save
      session[:user_type] = "Member"
      session[:id] = @member.id
      redirect_to @member
    elsif (auth2 == "login")
      @user = User.from_omniauth(auth)
      if User.find_by_id(@user.id)
        session[:id] = @user.id
        session[:user_type] = "Organization"
        redirect_to '/profile'
      else
        @member = Member.from_omniauth(auth)
        if Member.find_by_id(@member.id)
          session[:id] = @member.id
          session[:user_type] = "Member"
          redirect_to @member
        else
          redirect_to '/'
        end
      end
    end
    
  end

  def omniauth_user
    @user = User.from_omniauth(auth)
    @user.save
    session[:id] = @user.id
    redirect_to '/profile'
  end

  def omniauth_member
    @member = Member.from_omniauth(auth)
    @member.save
    session[:id] = @member.id
    redirect_to @member
  end
  private
  def auth
    request.env['omniauth.auth']
  end

  def auth2
    request.env["omniauth.params"]["from"]
    
  end
end

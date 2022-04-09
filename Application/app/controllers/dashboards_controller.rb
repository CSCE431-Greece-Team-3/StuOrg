class DashboardsController < ApplicationController
    skip_before_action :verify_authenticity_token
    layout 'dashboard'

    def dashboard
      @user = User.find_by_id(session[:id])
      @products = @user.products.all
    end
 
    def members
      @user = User.find_by_id(session[:id])
      @members = @user.members.all
    end
  end

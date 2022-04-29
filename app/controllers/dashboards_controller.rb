class DashboardsController < ApplicationController
    skip_before_action :verify_authenticity_token
    layout 'dashboard'

    # gets the associated products for the logged in organization
    def dashboard
      @user = User.find_by_id(session[:id])
      if @user
        @products = @user.products.all
      end
    end
 
    # gets the associated members for the logged in organization
    def members
      @user = User.find_by_id(session[:id])
      @members = @user.members.all
    end
  end

class UsersController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :logged_in_user, only: [:edit, :update, :show]
    # before_action :correct_user,   only: [:edit, :update, :show]

    def new
        @user = User.new
    end

    def index
        @user = User.find_by_id(session[:id])
        @members = Member.where(users_id: @user.id)
    end

    def remove_member
        @member = Member.find_by_id(params[:id])
        @member.update_attribute(:users_id, nil)

        respond_to do |format|
            format.html { redirect_to "/view_members", notice: "Member was removed from organization." }
            format.json { head :no_content }
        end
    end

    def add_members
    end

    def create_new_member
        @user = User.find_by_id(session[:id])
        if Member.exists?(username: params[:username])
            @member = Member.find_by_username(params[:username])
            @member.update_attribute(:users_id, @user.id)
            flash[:notice] = "User " + @member.first + " " + @member.last +  " was added to the organization."
        else
            flash[:notice] = "User does not exist." 
        end


        respond_to do |format|
            format.html { 
                if Member.exists?(username: params[:username]) 
                    redirect_to "/add_potential_members", notice: "User " + @member.first + " " + @member.last +  " was added to the organization."
                else
                    redirect_to "/add_potential_members", notice: "User does not exist."
                end
            }
            format.json { head :no_content }
        end
    end

        
    def create
        @user = User.new(user_params)
        if /\A[^@\s]+@[^@\s]+\z/.match(@user.username) == nil 
            flash[:notice] = "Invalid Username"
            redirect_to '/signup_organization'
        elsif User.find_by(username: @user.username)
            flash[:notice] = "Username already exists"
            redirect_to '/signup_organization'
        elsif @user.password.length < 8
            flash[:notice] = "Password length should be 8 or longer."
            redirect_to '/signup_organization'
        else @user.valid?
            @user = User.create(params.require(:user).permit(:first, :username, :password))
            session[:id] = @user.id
            session[:type] = "organization"
            redirect_to '/profile'
        end
    end

    def edit
        @user = User.find_by_id(session[:id])
    end

    def update
        @user = User.find_by_id(session[:id])
        # user_params = params.require(:user).permit(:username, :password, :first, :last)
        @user.assign_attributes(params.require(:user).permit(:first, :last, :username, :password))
        if @user.changed?
            if @user.save
                flash[:success] = true
            end
        end
        redirect_to '/profile'
    end

    def destroy
        @user = User.find_by_id(session[:id])
        Member.where(users_id: @user.id).update_all(users_id: nil)
        # @members.update_all(:users_id, nil)
        @user.destroy
        flash[:notice] = "User '#{@user.first}' deleted."
        redirect_to '/'
    end
    
    def show 
        @user = User.find_by_id(session[:id])
    end

    def user_params
        params.require(:user).permit(:first, :last, :username, :password)
    end

    def logged_in_user  
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to sign_in_url
        end
    end
end 
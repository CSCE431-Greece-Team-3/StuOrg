class UsersController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :logged_in_user, only: [:edit, :update, :show]
    # before_action :correct_user,   only: [:edit, :update, :show]

    # leads to account creation screen
    def new
        @user = User.new
    end

    # finds the members that a specific organiztion has
    def index
        @user = User.find_by_id(session[:id])
        @members = Member.where(users_id: @user.id)
    end

    # removes a specific member from the organization table
    def remove_member
        @member = Member.find_by_id(params[:id])
        @member.update_attribute(:users_id, nil)

        respond_to do |format|
            format.html { redirect_to "/view_members", notice: "Member was removed from organization." }
            format.json { head :no_content }
        end
    end

    # add_members form
    def add_members
    end

    # add a member to the organization based on username / email
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

    # creates a new organization based on correct parameters
    def create
        @user = User.new(user_params)
        if /\A[^@\s]+@[^@\s]+\z/.match(@user.username) == nil # checks to see if its a valid username / email
            flash[:notice] = "Invalid Username"
            redirect_to '/signup_organization'
        elsif User.find_by(username: @user.username) # checks to see if the username already exists in the organization table
            flash[:notice] = "Username already exists"
            redirect_to '/signup_organization'
        elsif @user.password.length < 8 # ensures that the password length is more than 8
            flash[:notice] = "Password length should be 8 or longer."
            redirect_to '/signup_organization'
        else @user.valid? # creates user in organization table
            @user = User.create(params.require(:user).permit(:first, :username, :password))
            session[:id] = @user.id
            session[:type] = "organization"
            redirect_to '/profile'
        end
    end

    # blind edit function
    def edit
        @user = User.find_by_id(session[:id])
    end

    # updates the parameters provided by the organization
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

    # deletes the organization from the table
    def destroy
        @user = User.find_by_id(session[:id])
        Member.where(users_id: @user.id).update_all(users_id: nil)
        # @members.update_all(:users_id, nil)
        @user.destroy
        flash[:notice] = "User '#{@user.first}' deleted."
        redirect_to '/'
    end
    
    # shows the information of the current organization logged in
    def show 
        @user = User.find_by_id(session[:id])
    end

    # creates the valid user paramters accepted by the create and update functions
    def user_params
        params.require(:user).permit(:first, :last, :username, :password)
    end

    # verifies an organization is logged in
    def logged_in_user  
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to sign_in_url
        end
    end
end 
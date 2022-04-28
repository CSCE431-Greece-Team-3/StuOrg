class MembersController < ApplicationController
  # before_action :set_member, only: %i[ show edit update destroy ]

  # gets all of the members created
  def index
    @members = Member.all
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
    @member = Member.find_by_id(session[:id])
  end

  # creates the member with the specified username, password, first name, and last name
  def create
    @member = Member.new(member_params)
    if /\A[^@\s]+@[^@\s]+\z/.match(@member.username) == nil # checks if the username is a valid email address
        flash[:notice] = "Invalid Username"
        redirect_to '/signup_member'
    elsif Member.find_by(username: @member.username) # checks to see if the username already exists
        flash[:notice] = "Username already exists"
        redirect_to '/signup_member'
    elsif @member.password.length < 8 # checks to ensure that the password length is at least 8 characters long
        flash[:notice] = "Password length should be 8 or longer."
        redirect_to '/signup_member'
    else @member.valid? # if has all valid parameters, create the member in the table
        @member = Member.create(params.require(:member).permit(:first, :last, :username, :password))
        @member.update_attribute(:referral_code, rand(36**8).to_s(36))
        @member.update_attribute(:num_referred, 0)
        session[:id] = @member.id
        session[:type] = "member"
        redirect_to '/mem_profile'
    end
  end

  # edits the member based on the parameters provided by the form
  def update
    @member = Member.find_by_id(session[:id])
    # user_params = params.require(:user).permit(:username, :password, :first, :last)
    @member.assign_attributes(params.require(:member).permit(:first, :last, :username, :password))
    if @member.changed?
        if @member.save
            flash[:success] = true
        end
    end
    redirect_to '/mem_profile'
  end


  
  # deletes the chosen member from the table
  def destroy
    @member = Member.find_by_id(session[:id])
    @member.destroy
    flash[:notice] = "Member '#{@member.first}' deleted."
    redirect_to '/'
  end

  private
    # list of trusted parameters associated with the member
    def member_params
      params.require(:member).permit(:username, :password, :first, :last)
    end
end

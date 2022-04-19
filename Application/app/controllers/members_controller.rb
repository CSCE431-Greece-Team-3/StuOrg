class MembersController < ApplicationController
  # before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members or /members.json
  def index
    @members = Member.all
  end

  # GET /members/1 or /members/1.json
  def show
    # if current_member.users_id.empty?
    #   @org_name = ""
    # else 
    #   @org_num = current_member.users_id
    #   @org = User.find_by_id(@org_num)
    #   @org_name = @org.first
    # end
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
    @member = Member.find_by_id(session[:id])
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)
    if /\A[^@\s]+@[^@\s]+\z/.match(@member.username) == nil 
        flash[:notice] = "Invalid Username"
        redirect_to '/signup_member'
    elsif Member.find_by(username: @member.username)
        flash[:notice] = "Username already exists"
        redirect_to '/signup_member'
    elsif @member.password.length < 8
        flash[:notice] = "Password length should be 8 or longer."
        redirect_to '/signup_member'
    else @member.valid?
        @member = Member.create(params.require(:member).permit(:first, :last, :username, :password))
        @member.update_attribute(:referral_code, rand(36**8).to_s(36))
        @member.update_attribute(:num_referred, 0)
        session[:id] = @member.id
        session[:type] = "member"
        redirect_to '/mem_profile'
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
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

  # DELETE /members/1 or /members/1.json
  def destroy
    @member = Member.find_by_id(session[:id])
    @member.destroy
    flash[:notice] = "Member '#{@member.first}' deleted."
    redirect_to '/'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_member
    #   @member = Member.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:username, :password, :first, :last)
    end
end

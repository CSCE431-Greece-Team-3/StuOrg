require 'rails_helper'

RSpec.describe SessionsController, type: :controller do 
    before(:each) do
        if User.where(:username => "rspec_user@gmail.com").empty?
            User.create(:username => "rspec_user@gmail.com", :password => "12345678", :first => "rspec")
        end
        @user = User.find_by_username("rspec_user@gmail.com")

        if Member.where(:username => "rspec_member@gmail.com").empty?
            Member.create(:username => "rspec_member@gmail.com", :password => "12345678", :first => "rspec")
        end
        @member = Member.find_by_username("rspec_member@gmail.com")

        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
    end

    describe "creates" do
        it "sessions with valid parameters" do
            post :create, params: {session: { username: @user.username, password: 12345678 }}
            expect(response).to redirect_to "/profile"
        end
    end

    describe "creates" do
        it "sessions with valid parameters" do
            post :create, params: {session: { username: @member.username, password: 12345678 }}
            expect(response).to redirect_to @member
        end
    end

    describe "creates" do
        it "sessions with invalid parameters" do
            post :create, params: {session: { username: @user.username, password: "21321321321" }}
            expect(response).to redirect_to "/sign_in"
        end
    end

    describe "destroy" do
        it "sessions " do
            get :destroy
            expect(response).to redirect_to "/"
        end
    end
end
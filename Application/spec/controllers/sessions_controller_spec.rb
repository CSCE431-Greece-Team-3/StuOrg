require 'rails_helper'

RSpec.describe SessionsController, type: :controller do 
    before(:each) do
        @user = User.create(:username => "rspec_user@gmail.com", :password => "12345678", :first => "rspec")
    end

    describe "creates" do
        it "sessions with valid parameters" do
            post :create, params: {session: { username: @user.username, password: @user.password }}
            expect(response).to redirect_to "/profile"
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
require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
    before(:all) do
        if User.where(:username => "rspec_user@gmail.com").empty?
          User.create(:username => "rspec_user@gmail.com", :password => "12345678", :first => "rspec")
        end
    end

    describe "creates" do
        it "user with valid parameters" do
            get :create, params: {:user => {:username => "rspec_test@gmail.com", :password => "12345678", :first => "rspec2"}}
            expect(response).to redirect_to "/profile"
            User.find_by(:username => "rspec_test@gmail.com").destroy
        end
    end

    describe "creates" do
        it "user with invalid parameters" do
            get :create, params: {:user => {:username => "rspec_test@gmail.com", :password => "45678", :first => "rspec2"}}
            expect(response).to redirect_to "/signup"
            expect(flash[:notice]).to match(/Password length should be 8 or longer./)
        end
    end

    describe "creates" do
        it "user with invalid parameters" do
            get :create, params: {:user => {:username => "rspec_user@gmail.com", :password => "12345678", :first => "rspec2"}}
            expect(response).to redirect_to "/signup"
            expect(flash[:notice]).to match(/Username already exists/)
        end
    end

    describe "creates" do
        it "user with invalid parameters" do
            get :create, params: {:user => {:username => "rspec_user", :password => "12345678", :first => "rspec2"}}
            expect(response).to redirect_to "/signup"
            expect(flash[:notice]).to match(/Invalid Username/)
        end
    end 

    describe "updates" do
        it "an existing user" do
            get :create, params: {:user => {:username => "rspec_test@gmail.com", :password => "12345678", :first => "rspec2"}}
            user = User.find_by_username("rspec_test@gmail.com")
            get :update, params: {:id => user.id, :user => {:username => "rspec10"}}
            expect(response).to redirect_to "/profile"
            expect(flash[:success]).to match(true)
        end
    end

    describe "deletes" do
        it "a user with valid parameters" do
            get :create, params: {:user => {:username => "rspec_test@gmail.com", :password => "12345678", :first => "rspec2"}}
            user = User.find_by_username("rspec_test@gmail.com")
            post :destroy, params: {:id => user.id}
            expect(response).to redirect_to "/"
            expect(flash[:notice]).to match(/User 'rspec2' deleted./)
        end
    end

    describe "gets" do
        it "the edit" do
            get :edit
        end
    end

    describe "gets" do
        it "the show" do
            get :show
        end
    end

    describe "gets" do
        it "the new" do
            get :new
        end
    end
end

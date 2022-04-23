require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
    before(:all) do
        if User.where(:username => "rspec_user@gmail.com").empty?
          User.create(:username => "rspec_user@gmail.com", :password => "12345678", :first => "rspec")
        end
        @user = User.find_by_username("rspec_user@gmail.com")

        if Member.where(:username => "rspec_member@gmail.com").empty?
            Member.create(:username => "rspec_member@gmail.com", :password => "12345678", :first => "rspec", :last => "user", :num_referred => 0, :referral_code => "refer")
          end
        @member = Member.find_by_username("rspec_member@gmail.com")
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
            expect(response).to redirect_to "/signup_organization"
            expect(flash[:notice]).to match(/Password length should be 8 or longer./)
        end
    end

    describe "creates" do
        it "user with invalid parameters" do
            get :create, params: {:user => {:username => "rspec_user@gmail.com", :password => "12345678", :first => "rspec2"}}
            expect(response).to redirect_to "/signup_organization"
            expect(flash[:notice]).to match(/Username already exists/)
        end
    end

    describe "creates" do
        it "user with invalid parameters" do
            get :create, params: {:user => {:username => "rspec_user", :password => "12345678", :first => "rspec2"}}
            expect(response).to redirect_to "/signup_organization"
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
        it "the new" do
            get :new
        end
    end

    describe "gets" do
        it "add members" do
            get :add_members
        end
    end

    describe "gets" do 
        it "the index" do 
            get :index, session: {:id => @user.id}
        end
    end

    describe "creates" do
        it "new members" do
            post :create_new_member, session: {:id => @user.id}, params: {:username => @member.username}
            expect(flash[:notice]).to match("User " + @member.first + " " + @member.last +  " was added to the organization.")
        end
    end

    describe "removes" do
        it "the member" do 
            delete :remove_member, params: {:id => @member.id}
        end
    end
end

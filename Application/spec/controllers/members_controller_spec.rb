require 'rails_helper'

RSpec.describe MembersController, type: :controller do 
    before(:all) do
        if Member.where(:username => "rspec_member@gmail.com").empty?
          Member.create(:username => "rspec_member@gmail.com", :password => "12345678", :first => "rspec", :last => "user", :num_referred => 0, :referral_code => "refer")
        end
        @member = Member.find_by_username("rspec_member@gmail.com")

    end

    describe "creates" do
        it "member with valid parameters" do
            get :create, params: {:member => {:username => "rspec_test@gmail.com", :password => "12345678", :first => "rspec", :last => "user"}}
            expect(response).to redirect_to "/mem_profile"
            Member.find_by(:username => "rspec_test@gmail.com").destroy
        end
    end

    describe "creates" do
        it "member with invalid parameters" do
            get :create, params: {:member => {:username => "rspec_test@gmail.com", :password => "5678", :first => "rspec", :last => "user"}}
            expect(response).to redirect_to "/signup_member"
            expect(flash[:notice]).to match(/Password length should be 8 or longer./)
        end
    end

    describe "creates" do
        it "member with invalid parameters" do
            get :create, params: {:member => {:username => "rspec_member@gmail.com", :password => "12345678", :first => "rspec", :last => "user"}}
            expect(response).to redirect_to "/signup_member"
            expect(flash[:notice]).to match(/Username already exists/)
        end
    end

    describe "creates" do
        it "member with invalid parameters" do
            get :create, params: {:member => {:username => "rspec_test", :password => "12345678", :first => "rspec", :last => "user"}}
            expect(response).to redirect_to "/signup_member"
            expect(flash[:notice]).to match(/Invalid Username/)
        end
    end 

    describe "updates" do
        it "an existing member" do
            get :create, params: {:member => {:username => "rspec_test@gmail.com", :password => "12345678", :first => "rspec", :last => "user"}}
            member = Member.find_by_username("rspec_test@gmail.com")
            get :update, params: {:id => member.id, :member => {:username => "rspec10"}}
            expect(response).to redirect_to "/mem_profile"
            expect(flash[:success]).to match(true)
        end
    end

    describe "deletes" do
        it "a member with valid parameters" do
            get :create, params: {:member => {:username => "rspec_test@gmail.com", :password => "12345678", :first => "rspec2", :last => "user", :num_referred => 0, :referral_code => "refer"}}
            member = Member.find_by_username("rspec_test@gmail.com")
            post :destroy, params: {:id => member.id}
            expect(response).to redirect_to "/"
            expect(flash[:notice]).to match(/Member 'rspec2' deleted./)
        end
    end
end

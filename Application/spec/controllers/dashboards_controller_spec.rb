require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do 
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
        it "the dashboard" do
            get :dashboard, session: {:id => @user.id}
        end
    end

    # describe "gets" do
    #     it "the members" do
    #         get :members, session: {:id => @user.id}
    #     end
    # end
end
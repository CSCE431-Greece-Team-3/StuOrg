require 'rails_helper'

RSpec.describe OrdersController, type: :controller do 
    describe "gets" do 
        it "the index" do 
            get :index
        end
    end 

    describe "creates" do 
        it "the order" do 
            get :create_order, session: {:total => 100.00}
        end
    end

    describe "captures" do 
        it "the order" do 
            post :capture_order
        end
    end
end
require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do 
    describe "gets" do
        it "new articles" do
            get :index
        end
    end
end
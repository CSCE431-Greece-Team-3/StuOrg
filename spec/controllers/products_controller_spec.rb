require 'rails_helper'

RSpec.describe ProductsController, type: :controller do 
    before(:each) do

        if User.where(:username => "rspec_user@gmail.com").empty?
            User.create(:username => "rspec_user@gmail.com", :password => "12345678", :first => "rspec")
        end

        @user = User.find_by_username("rspec_user@gmail.com")

        @image = fixture_file_upload("water_bottle_metal.jpg")
        if Product.where(:title => "Metal Bottle").empty?
        #   Product.create(:title => "Metal Bottle", :image => @image)
        post :create, session: {:id => @user.id}, params: {:product => {:title => "Metal Bottle", :image => @image, :price => 10.99, :quantity => 10, :tags => nil}}
        end

        if Member.where(:username => "rspec_member@gmail.com").empty?
            Member.create(:username => "rspec_member@gmail.com", :password => "12345678", :first => "rspec", :last => "user", :num_referred => 0, :referral_code => "refer")
        end
        
        @member = Member.find_by_username("rspec_member@gmail.com")

        @product = Product.find_by_title("Metal Bottle")
        post :add_to_cart, params: {:product_id => @product.id}, session: {:referral => "refer"}
    end

    describe "creates" do
        it "product with valid parameters" do
            # @image2 = Rack::Test::UploadedFile.new("features/test_images/water_bottle.jpg")
            file = Rails.root.join('features', 'test_images', 'water_bottle.jpg')
            image = ActiveStorage::Blob.create_and_upload!(
                io: File.open(file, 'rb'),
                 filename: 'water_bottle.jpg',
                 content_type: 'image/jpg' # Or figure it out from `name` if you have non-JPEGs
               ).signed_id
            post :create, session: {:id => @user.id}, params: {:product => {:title => "Bottle", :image => image, :price => 10.99, :quantity => 5, :tags => nil}}
            # expect(response).to redirect product_url + "/" + product.id.to_s
            expect(flash[:notice]).to match(/Product was successfully created./)
            # Product.find_by(:title => "Bottle").destroy
        end
    end

    describe "deletes" do
        it "an existing product" do
            product = Product.find_by_title("Metal Bottle")
            user = User.find_by_username('rspec_user@gmail.com')
            post :destroy, params: {:id => product.id}, session: {:id => @user.id}
            expect(response).to redirect_to products_url
            expect(flash[:notice]).to match(/Product was successfully destroyed./)
        end
    end

    describe "updates" do
        it "an existing product" do
            product = Product.find_by_title("Metal Bottle")
            get :update, params: {:id => product.id, :product => {:title => "A Bottle"}}, session: {:id => @user.id}
            expect(response).to redirect_to products_url + "/" + product.id.to_s
            expect(flash[:notice]).to match(/Product was successfully updated./)
        end
    end

    describe "gets" do
        it "the increasing price marketplace" do
            get :marketplace, params: {:sort => "Increasing Price"}
        end
    end

    describe "gets" do
        it "the decreasing price marketplace" do
            get :marketplace, params: {:sort => "Decreasing Price"}
        end
    end

    describe "gets" do
        it "the marketplace" do
            get :marketplace
        end
    end

    describe "gets" do
        it "the organization's products" do
            get :index, session: {:id => @user.id}
        end
    end

    describe "gets" do
        it "new product" do
            get :new
        end
    end

    describe "gets" do
        it "the tag marketplace" do 
            @tag = Tag.find_by_name("Shirt")
            post :tag_marketplace, params: {:tag_id => @tag.id}
        end
    end

    describe "gets" do
        it "the org marketplace" do 
            post :org_marketplace, params: {:org_id => @user_id}
        end
    end

    describe "posts" do
        it "the referral" do 
            post :set_referral, params: {:referral_code => "refer"}
        end
    end

    describe "gets" do
        it "the cart" do 
            get :view_cart
        end
    end

    describe "removes" do
        it "from cart" do 
            delete :remove_from_cart, params: {:product_id => @product.id}
        end
    end
end
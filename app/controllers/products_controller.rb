class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product, :initialize_cart, only: %i[ show edit update destroy ]

  # gets the products owned by the organizations
  def index
    @user = User.find_by_id(session[:id])
    @products = @user.products.all
  end

  # handles the marketplace and the sorting functionality; order(id) to ensure that the order remains the same after adding to cart
  def marketplace
    @tags = Tag.all
    @users = User.all
    @products = Product.order(:id).all
    if params[:sort] == "Increasing Price"
      @products = @products.order(:id).all.sort_by { |p| [p.price] }
    elsif params[:sort] == "Decreasing Price"
      @products = @products.order(:id).all.sort_by { |p| [p.price] }.reverse
    else
      @products = Product.order(:id).all
    end
  end

  # creates the cart when entering the marketplace 
  def initialize_cart
    session[:cart] ||= []
    session[:referral] = nil
  end

  # calculates the total item value in the cart to give to front end, checks if a valid referral code was entered
  def view_cart
    @cart_ids = session[:cart]
    @total = 0
    if @cart_ids != nil
      @cart_ids.each do |cart_id|
        @total += Product.find_by_id(cart_id).price
      end
    end

    session[:total] = @total

    @member_refer = Member.find_by_referral_code(session[:referral])
    if @member_refer != nil
      @member_refer = Member.find_by_referral_code(session[:referral]).first
    end
  end 

  # adds the item pressed by the user to the cart and also increments the number of referred products if a valid referral code was entered
  def add_to_cart
    session[:cart] ||= []
    session[:cart] << params[:product_id]

    @product = Product.find_by_id(params[:product_id])
    new_quantity = @product.quantity - 1
    @product.update_attribute(:quantity, new_quantity)

    @member_refer ||= Member.find_by_referral_code(session[:referral])
    if @member_refer != nil
      new_refer = @member_refer.num_referred + 1
      @member_refer.update_attribute(:num_referred, new_refer)
    end
    redirect_to "/marketplace"
  end

  # removes the item pressed by the user to the cart and also deccrements the number of referred products if a valid referral code was entered
  def remove_from_cart
    session[:cart].delete_at(session[:cart].index(params[:product_id]))
    @product = Product.find_by_id(params[:product_id])
    new_quantity = @product.quantity + 1
    @product.update_attribute(:quantity, new_quantity)

    @member_refer ||= Member.find_by_referral_code(session[:referral])
    if @member_refer != nil
      new_refer = @member_refer.num_referred - 1
      @member_refer.update_attribute(:num_referred, new_refer)
    end

    redirect_to "/view_cart"
  end

  # sets referral in session hash
  def set_referral
    session[:referral] = params[:referral_code]
    redirect_to "/marketplace"
  end

  # gets products where the organization matches the choice
  def org_marketplace
    if params[:org_id] == nil
      redirect_to "/marketplace"
    end
    @products = Product.where(user_id: params[:org_id])
  end

  # gets products where the tags matches the choice
  def tag_marketplace
    if params[:tag_id] == nil
      redirect_to "/marketplace"
    end
    @selected_tag = Tag.find_by_id(params[:tag_id]).name
    @product_ids = Tagging.where(tag_id: params[:tag_id]).pluck(:product_id)

    @products = Product.where(id: @product_ids)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # creates the product with the following inputs: title, image, price, tags, and quantity
  def create
    @user = User.find_by_id(session[:id])
    product_params = params.require(:product).permit(:title, :image, :price, :tag_list, :tag, { tag_ids: [] }, :tag_ids, :quantity)
    @product = @user.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # updates the product model with the user's specifications
  def update
    product_params = params.require(:product).permit(:title, :image, :price, :tag_list, :tag, { tag_ids: [] }, :tag_ids, :quantity)
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # deletes the chosen product model from the database
  def destroy
    @user = User.find_by_id(session[:id])
    @product = @user.products.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Sets the current product 
    def set_product
      @product = Product.find(params[:id])
    end
end

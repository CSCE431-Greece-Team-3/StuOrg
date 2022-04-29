class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'application'

  def index
    @products = Product.all
  end

  def internal_server_error
  end
end

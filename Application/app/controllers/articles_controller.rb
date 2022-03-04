class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'application'

  def index
  end
end

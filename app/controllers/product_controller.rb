class ProductController < ApplicationController
  before_action :get_product, only: [:show]

  def show
    @chart_hash = @product.price_log_hash

  end

  private

  def get_product
    @product = Product.find(params[:id])
  end
end
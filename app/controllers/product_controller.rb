class ProductController < ApplicationController
  before_action :get_product, only: [:show]

  def show

  end

  private

  def get_product
    @product = Product.find(params[:id])
  end
end
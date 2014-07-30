class ProductsController < ApplicationController
  before_action :get_product, only: [:show]

  def show
    meta_tag_setter(
      "#{@product.title}",
      'Best discounts for health and beauty products',
      "#{@product.title}," + key_words,
      false
    )
    @chart_hash = @product.price_log_hash
  end


  private
  def get_product
    @product = Product.find(params[:id])
  end
end
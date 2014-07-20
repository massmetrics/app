class CategoryController < ApplicationController

  def index
    @categories = Category.category_list
    @products = Product.percent_discounts(10, 30)
  end

  def show
    @products = Product.category_discounts(params[:id])
  end

end
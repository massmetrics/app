class CategoryController < ApplicationController

  def index
    @categories = Category.category_list
  end

  def show
    @products = Product.category_discounts(params[:id])
  end

end
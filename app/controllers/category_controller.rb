class CategoryController < ApplicationController

  def index
    @categories = Category.category_list
  end

  def show
    @products = Product.get_products_for(params[:id])
  end

end
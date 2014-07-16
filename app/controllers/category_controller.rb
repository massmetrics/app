class CategoryController < ApplicationController

  def index
    @categories = Category.category_list
  end
end
class CategoryController < ApplicationController

  def index
    meta_tag_setter(
      'Categories',
      'Best discounts for health and beauty products',
      'best, health, fitness, supplements, cheap, cheapest, protein, health supplements, protein powder, diet, exercise',
      false
    )
    # @categories = Category.category_list
    @categories = Category.all.map {|category| category.category}.uniq
    @products = Product.percent_discounts(10, 30)
  end

  def show
    @category = params[:id]
    meta_tag_setter(
      "#{@category}",
      'Best discounts for health and beauty products',
      "#{@category}," + key_words,
      false
    )
    @categories = Category.all.map {|category| category.category}.uniq
    @products = Product.category_discounts(@category)
  end
end
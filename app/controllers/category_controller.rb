class CategoryController < ApplicationController

  def index
    meta_tag_setter(
        'Categories',
        'Best discounts for health and beauty products',
        'best, health, fitness, supplements, cheap, cheapest, protein, health supplements, protein powder, diet, exercise',
        false
    )
    # @categories = Category.category_list
    @categories = Category.all.map { |category| category.name }.uniq
    products = Product.category_discounts(nil, 20, 30)
    @products = Kaminari.paginate_array(products).page(params[:page]).per(10)
  end

  def show
    @category = params[:id]
    meta_tag_setter(
        "#{@category}",
        'Best discounts for health and beauty products',
        "#{@category}," + key_words,
        false
    )
    # @categories = Category.category_list
    @categories = Category.all.map { |category| category.name }.uniq
    products = Product.category_discounts(@category)
    @products = Kaminari.paginate_array(products).page(params[:page]).per(10)
  end
end

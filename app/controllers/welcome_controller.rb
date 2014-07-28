class WelcomeController < ApplicationController

  def index
    meta_tag_setter(
      "All Products",
      'Best discounts for health and beauty products',
      key_words,
      false
    )
    @products = Product.percent_discounts(10, 30)
  end
end
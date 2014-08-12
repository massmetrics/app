class WelcomeController < ApplicationController

  def about
    meta_tag_setter(
      "All Products",
      'Best discounts for health and beauty products',
      key_words,
      false
    )
  end
end
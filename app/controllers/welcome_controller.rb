class WelcomeController < ApplicationController

  def index
    @products = Product.percent_discounts(10, 30)
  end
end
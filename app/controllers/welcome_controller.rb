class WelcomeController < ApplicationController

  def index
    @products = Product.all
    @currency = ProductCurrency.new
  end
end
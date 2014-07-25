class MyProductsController < ApplicationController
  before_action :get_product
  before_filter :verify_logged_in

  def create
    @my_product = MyProduct.new(product: @product, user: current_user)
    if @my_product.save
      redirect_to @product
    else
      redirect_to @product, notice: @my_product.errors.full_messages.first
    end
  end

  def destroy
    MyProduct.find(params[:id]).destroy
    redirect_to(current_user)
  end

  private
  def get_product
    @product = Product.find(params[:product_id])
  end

  def verify_logged_in
    redirect_back_or_to(@product, notice: 'You must log in to track products') unless logged_in?
  end
end
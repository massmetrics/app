class MyProductsController < ApplicationController
  before_action :get_product
  before_filter :verify_logged_in

  def create
    MyProduct.create(product: @product, user: current_user)
    redirect_to user_path(current_user)
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
    redirect_back_or_to(:back, notice: "You must log in to track products") unless logged_in?
  end
end
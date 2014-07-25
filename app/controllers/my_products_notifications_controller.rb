class MyProductsNotificationsController < ApplicationController
  def create
    my_product = MyProduct.find(params[:my_product])
    discount = NumberFormatter.string_to_float(params[:my_products_notification][:discount])
    @my_products_notification = MyProductsNotification.new(my_product: my_product, discount: discount)
    if @my_products_notification.save
      redirect_to current_user
    else
      redirect_to current_user, notice: 'Invalid format for discount'
    end
  end
end
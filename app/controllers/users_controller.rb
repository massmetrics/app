class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_filter :verify_user, only: [:show]

  def new
    meta_tag_setter(
      "Login",
      'Best discounts for health and beauty products',
      key_words,
      false
    )
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      login(@user.email, params[:user][:password])
      redirect_back_or_to(root_path)
    else
      render :new
    end
  end

  def show
    meta_tag_setter(
      "My products",
      'Best discounts for health and beauty products',
      key_words,
      false
    )
    @my_products = @user.my_products.includes(:my_products_notification)
    @my_product_notification = MyProductsNotification.new
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def allowed_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def verify_user
    redirect_to root_path, notice: "You don't have permission to access that page" unless current_user == @user || (logged_in? && current_user.role?(:admin))
  end
end

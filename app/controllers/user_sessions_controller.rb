class UserSessionsController < ApplicationController

  def new
    meta_tag_setter(
    "Register",
    'Best discounts for health and beauty products',
    key_words,
    false
  )
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password])
      redirect_back_or_to(root_path)
    else
      @user = User.new
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end
end
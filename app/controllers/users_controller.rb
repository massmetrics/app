class UsersController < ApplicationController
  def new
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

  private
  def allowed_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
